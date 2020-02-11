require 'puppet/resource_api/simple_provider'
require 'oauth'
require 'json'

module PuppetX
  module ForemanApi
    module Api
      def self.api
        unless @api
          @api = Puppet::Type.type(:foreman_resource).provider(:rest_v3).new
          @api.resource = {
            base_url: 'http://localhost:3000/',
            effective_user: 'admin',
          }
        end
        @api
      end
      def self.request(method, path, params = {}, data = nil, headers = {})
        r = api.request(method, path, params, data, headers)
        raise Puppet::Error, "failed to #{method.to_s.upcase} \"#{path}\": #{api.error_message(r)} (#{r})" unless api.success?(r)
        JSON.load(r.body)
      end

      def self.get(path, params = {})
        request(:get, path, params)
      end

      def self.put(path, data, params = {})
        request(:put, path, params, data.to_json)
      end

      def self.post(path, data, params = {})
        request(:post, path, params, data.to_json)
      end

      def self.delete(path)
        request(:delete, path)
      end
    end

    class SimpleAttr
      attr_reader :definition, :value
      def initialize(definition, object)
        @definition = definition
        @object = object
        @value = nil
      end

      def get(side = :api)
        @definition.get(@value, side)
      end

      def set(value, side = :api)
        newval = @definition.set(value, side)
        @value = newval if newval != :undefined
      end
    end
    class CompositeNamevarAttr
      attr_reader :definition
      def initialize(composite_attributes, object)
        @attributes = composite_attributes
        @object = object
        @definition = AttrDefinition.new(:title, '_namevar', '_namevar')
      end

      def get(side = :api)
        return Hash[] if side == :api
        title = @attributes.map { |attr| @object.get(attr, side) }.join('/')
        Hash[:title, title]
      end

      def set(_value, _side = :api); end
    end
    class AttrDefinition
      attr_reader :puppetname, :readname, :writename, :detailed
      def initialize(puppetname, readname, writename, detailed: false)
        @puppetname = puppetname
        @readname = readname
        @writename = writename
        @detailed = detailed
      end

      def get(value, side = :api)
        return get_for_api(value) if side == :api
        return get_for_puppet(value) if side == :puppet
      end

      def set(hash, side = :api)
        return set_from_api(hash) if side == :api
        return set_from_puppet(hash) if side == :puppet
      end

      def get_for_puppet(value)
        Hash[puppetname, value]
      end

      def set_from_puppet(hash)
        return :undefined unless hash.key? puppetname
        hash[puppetname]
      end

      def get_for_api(value)
        return Hash[] if writename.nil?
        Hash[writename, value]
      end

      def set_from_api(hash)
        return :undefined unless hash.key? readname
        hash[readname]
      end
    end
    class ForeignKeyAttrDefinition < AttrDefinition
      attr_reader :foreign_provider
      def initialize(puppetname, readname, writename, foreign_provider, detailed: false)
        super(puppetname, readname, writename, detailed: detailed)
        @foreign_provider = foreign_provider
      end

      def _to_id(name)
        return name if name.is_a? Integer # we already have the id…
        @foreign_provider.endpoint.instances(:name)[name].get('id', :api)
      end

      def _to_name(id)
        return nil if id.nil?
        return id unless @foreign_provider.endpoint.instances(:id).key? id
        instance = @foreign_provider.endpoint.instances(:id)[id]
        return instance.get(:name, :puppet) if instance.get(:name, :puppet)
        instance.get(:title, :puppet)
      end

      def get_for_puppet(value)
        super(_to_name(value))
      end

      def set_from_puppet(hash)
        return :undefined unless hash.key? puppetname
        _to_id(super(hash))
      end

      def set_from_api(hash)
        return :undefined unless hash.key? readname
        hash[readname].is_a?(Hash) ? hash[readname]['id'].to_i : hash[readname].to_i
      end
    end
    class ForeignKeyArrayAttrDefinition < ForeignKeyAttrDefinition
      def get_for_puppet(values)
        return nil unless values
        Hash[puppetname, values.map { |value| _to_name(value) }]
      end

      def set_from_puppet(hash)
        return :undefined unless hash.key? puppetname
        hash[@puppetname].map { |value| _to_id(value) }
      end

      def set_from_api(hash)
        return :undefined unless hash.key? readname
        hash[readname].map do |e|
          e.is_a?(Hash) ? e['id'].to_i : e.to_i
        end
      end
    end

    class ApiObject
      def initialize(endpoint, hash, side = :api)
        @endpoint = endpoint
        @attrs = {
          api: {},
          puppet: {},
        }

        @endpoint.attributes.each do |attrdef|
          attr = SimpleAttr.new(attrdef, self)
          attr.set(hash, side)
          @attrs[:puppet][attrdef.puppetname] = attr
          @attrs[:api][attrdef.readname] = attr
        end
        if @endpoint.composite_namevar
          attr = CompositeNamevarAttr.new(@endpoint.composite_namevar, self)
          @attrs[:puppet][:title] = attr
          @attrs[:api]['_namevar'] = attr
        end
        @mapped = {
          api: nil,
          puppet: nil,
        }
        @mapped[side] = hash
        @details_loaded = (side == :puppet)
      end

      def load_details
        url = @endpoint.detailurl.resolve @mapped[:api]
        set_all(url.get, :api)
        @details_loaded = true
      end

      def _get_all(side = :api)
        if @mapped[side].nil?
          @mapped[side] = @attrs[side].reduce({}) do |h, (_k, a)|
            h.merge!(a.get(side))
          end
        end
      end

      def get(attrname, side = :api)
        return nil unless @attrs[side].key? attrname
        attr = @attrs[side][attrname]
        if attr.definition.detailed && @details_loaded == false
          load_details
        end
        attr.get(side)[attrname]
      end

      def get_all(side = :api)
        load_details if @details_loaded == false
        _get_all(side)
        @mapped[side]
      end

      def set_all(hash, side = :api)
        @attrs[side].each do |_k, attr|
          attr.set(hash, side)
        end
        @mapped = {
          api: nil,
          puppet: nil,
        }
        @mapped[side] = hash
        @details_loaded = true
      end

      def _normalize_for_api(hash)
        normalized = Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }
        keyregex = %r{^([^\[]+)(?:\[([^\]]+)\])?(?:\[([^\]]+)\])?(?:\[([^\]]+)\])?(?:\[([^\]]+)\])?$}
        hash.each do |k, v|
          next if v.nil?
          keyparts = keyregex.match(k).captures.compact
          if keyparts.length == 1
            normalized[k] = v
          else
            normalized.dig(*keyparts[0..-2])[keyparts[-1]] = v
          end
        end
        normalized
      end

      def delete
        _get_all(:api)
        url = @endpoint.detailurl.resolve @mapped[:api]
        url.delete
      end

      def update
        _get_all(:api)
        url = @endpoint.detailurl.resolve @mapped[:api]
        url.put _normalize_for_api(@mapped[:api])
      end

      def create
        _get_all(:api)
        url = @endpoint.url.resolve @mapped[:api]
        url.post _normalize_for_api(@mapped[:api])
      end
    end

    class ApiUrl
      attr_reader :path
      def initialize(path)
        @path = path
      end

      def get(params = {})
        Api.get(@path, params)
      end

      def put(data, params = {})
        Api.put(@path, data, params)
      end

      def post(data, params = {})
        Api.post(@path, data, params)
      end

      def delete
        Api.delete(@path)
      end
    end

    class ParameterizedURL
      def initialize(url)
        @parts = url.split('/')
        @params = @parts.select { |e| e[0] == ':' }
      end

      def params
        @params.map { |param| param[1..-1] }
      end

      def resolve(hash = {})
        resolved = @parts.map do |part|
          if part[0] != ':'
            part
          elsif block_given?
            yield(part[1..-1])
          else
            hash[part[1..-1]]
          end
        end
        ApiUrl.new(resolved.join('/'))
      end
    end

    class Endpoint
      attr_reader :url, :detailurl, :attributes, :composite_namevar
      def initialize(url: nil, detailurl: nil, attributes: {}, composite_namevar: nil)
        @url = ParameterizedURL.new(url)
        @detailurl = ParameterizedURL.new(detailurl) unless detailurl.nil?
        @attributes = attributes
        @composite_namevar = composite_namevar
        @iterated = false
        @instances = {
          name: nil,
          id: nil,
        }
      end

      def _itterate
        results = []
        if @url.params.empty?
          reply = @url.resolve({}).get(per_page: 10_000)
          results += reply['results']
        else
          other_ids = @url.params.map do |param|
            attr = @attributes.find { |a| a.readname == param }
            other_instances = attr.foreign_provider.endpoint.instances(:id)
            other_instances.keys.map do |id|
              Hash[param, id]
            end
          end
          other_ids = other_ids[0].product(*other_ids[1..-1])
          other_ids.each do |idset|
            idset_merged = idset.reduce({}) { |h, a| h.merge!(a) }
            begin
              reply = @url.resolve(idset_merged).get(per_page: 10_000)
              res = reply['results'].map do |r|
                idset_merged.merge r
              end
              results += res
            rescue Exception => e
              # TODO: loging
            end
          end
        end
        instances = {
          name: {},
          id: {},
        }
        results.each do |result|
          obj = ApiObject.new(self, result)
          if obj.get(:name, :puppet)
            instances[:name][obj.get(:name, :puppet)] = obj
          else
            instances[:name][obj.get(:title, :puppet)] = obj
          end
          instances[:id][obj.get(:id, :puppet)] = obj
        end
        @instances = instances
      end

      def instances(by = :name)
        _itterate unless @instances[by]
        @instances[by]
      end

      def create(name, puppet_hash)
        puppet_hash[:name] = name
        obj = ApiObject.new(self, puppet_hash, :puppet)
        obj.set_all(puppet_hash, :puppet)
        obj.create
      end
    end

    class EndpointProvider < Puppet::ResourceApi::SimpleProvider
      def get(_context)
        self.class.endpoint.instances.map do |_name, instance|
          { ensure: 'present' }.merge(instance.get_all(:puppet))
        end
      end

      def update(_context, name, should)
        obj = self.class.endpoint.instances(:name)[name]
        obj.set_all(should, :puppet)
        obj.update
      end

      def create(_context, name, should)
        self.class.endpoint.create(name, should)
      end

      def delete(_context, name)
        obj = self.class.endpoint.instances(:name)[name]
        obj.delete
      end
    end
  end
end

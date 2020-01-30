require 'json'
require 'yaml'
require 'pp'
require 'erb'
require 'fileutils'

module Extras
  refine Hash do
    def symbolize_keys
      dup.symbolize_keys!
    end

    def symbolize_keys!
      keys.each do |key|
        new_key = (begin
                     key.to_sym
                   rescue
                     key.to_s.to_sym
                   end)
        self[new_key] = delete(key)
      end
      self
    end
  end
end

module Config
  class << self
    attr_reader :apidocbasepath, :typemap, :static_attrs, :typetemplate, :providertemplate
  end
  @apidocbasepath = 'apidoc/v2'
  @typemap = {
    'string' => 'String',
    'boolean' => 'Boolean',
    'array' => 'Array',
    'numeric' => 'Numeric',
    'hash' => 'Hash',
  }
  @static_attrs = {
    'id' => {
      puppetname: 'id',
      readname: 'id',
      writname: nil,
      type: 'Integer',
      desc: 'internal numerical id',
      definition_class: 'AttrDefinition',
    },
  }
  @typetemplate = ERB.new(File.read('type.rb.erb'), nil, '-')
  @providertemplate = ERB.new(File.read('provider.rb.erb'), nil, '-')
end

def array_to_hash(hash, keyfield)
  hash.map { |e| [e[keyfield], e] }.to_h
end

def rubytypename(name)
  name.split('_').map { |part| part.capitalize }.join('')
end

class Endpoint
  using Extras
  def initialize(filename)
    begin
      config = YAML.load_file("config/#{filename}.yaml").symbolize_keys
    rescue
      config = {}
    end
    pp config
    _initialize(filename, **config)
  end

  def _initialize(filename, typename: nil, composite_namevar: nil, overrides: {}, apiurl: nil, detailurl: nil, extra: {})
    file = File.open "#{Config.apidocbasepath}/#{filename}.json"
    data = JSON.load file
    file.close
    data = data['docs']['resources'][0]
    @name = data['name']
    @methods = array_to_hash(data['methods'], 'name')
    p '---------'
    @singularname = if filename[-1] == 's'
                      filename[0..-2]
                    else
                      %r{^Update (?:an |a |)(.*)$}.match(@methods['update']['apis'][-1]['short_description'])[1]
                    end
    @pathname = "foreman_#{@singularname.tr(' ', '_')}"
    @pathname = "foreman_#{typename}" unless typename.nil?
    @rubyname = rubytypename(@pathname)
    p @pathname
    p @rubyname
    p '----overrides-----'
    pp overrides
    p '----extra-----'
    pp extra

    @composite_namevar = composite_namevar
    @overrides = overrides
    @apiurl = @methods['index']['apis'][0]['api_url']
    @apiurl = apiurl unless apiurl.nil?
    @detailurl = @methods['show']['apis'][0]['api_url']
    @detailurl = detailurl unless detailurl.nil?

    attributes = if @methods.key? 'create'
                   array_to_hash(@methods['create']['params'], 'name')
                 else
                   array_to_hash(@methods['update']['params'], 'name')
                 end
    attributes.delete('location_id')
    attributes.delete('organization_id')
    attributes = attributes.reduce({}) do |out, (k, v)|
      if v.key? 'params'
        out.merge(array_to_hash(v['params'], 'name'))
      else
        out.merge(k => v)
      end
    end

    pp extra
    extra = extra.map { |k, v|
      [k, v.symbolize_keys]
    }.to_h
    @attributes = Config.static_attrs.merge(extra).merge(attributes.map { |name, attr|
      hash = {
        puppetname: name,
        readname: name,
        writename: attr['full_name'],
        type: Config.typemap[attr['expected_type']],
        desc: attr['description'].gsub(/<p>(.*?)<\/p>/, "\\1\n\n").strip,
        definition_class: 'AttrDefinition',
        requires: nil,
      }
      hash[:behaviour] = :namevar if name == 'name'
      hash[:behaviour] = :namevar if @composite_namevar && @composite_namevar.include?(name)
      if %r{_ids$} =~ name
        typename = name.gsub(%r{_ids$}, '')
        typename = "foreman_#{typename}"
        rubyname = rubytypename(typename)
        hash.merge!(puppetname: name.gsub(%r{_ids$}, 's'),
                    readname: name.gsub(%r{_ids$}, 's'),
                    type: 'Array[Variant[String,Integer]]',
                    definition_class: 'ForeignKeyArrayAttrDefinition',
                    foreign_class: "::Puppet::Provider::#{rubyname}::#{rubyname}",
                    requires: "puppet/provider/#{typename}/#{typename}",
                    detailed: true)
      elsif %r{_id$} =~ name
        typename = name.gsub(%r{_id$}, '')
        typename = "foreman_#{typename}"
        rubyname = rubytypename(typename)
        hash.merge!(puppetname: name.gsub(%r{_id$}, ''),
                    writename: attr['full_name'],
                    type: 'Variant[String,Integer]',
                    definition_class: 'ForeignKeyAttrDefinition',
                    foreign_class: "::Puppet::Provider::#{rubyname}::#{rubyname}",
                    requires: "puppet/provider/#{typename}/#{typename}")
      end
      hash[:type] = "Optional[#{hash[:type]}]" unless attr['required']
      if @overrides.key? name
        hash.merge!(@overrides[name].symbolize_keys)
      end
      if hash.key?(:absent) && hash[:absent]
        next nil
      end
      [name, hash]
    }.compact.to_h)
    pp @attributes
  end

  def gentype
    p "../lib/puppet/type/#{@pathname}.rb"
    File.open("../lib/puppet/type/#{@pathname}.rb", 'w') do |f|
      f.write Config.typetemplate.result(binding)
    end
  end

  def genprovider
    FileUtils.mkdir_p "../lib/puppet/provider/#{@pathname}"
    File.open("../lib/puppet/provider/#{@pathname}/#{@pathname}.rb", 'w') do |f|
      f.write Config.providertemplate.result(binding)
    end
    p "../lib/puppet/provider/#{@pathname}/#{@pathname}.rb"
  end
end

ARGV.each do |name|
  e = Endpoint.new(name)
  e.genprovider
  e.gentype
end

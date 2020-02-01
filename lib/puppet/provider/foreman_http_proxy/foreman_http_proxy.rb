require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_location/foreman_location'
require 'puppet/provider/foreman_organization/foreman_organization'

module ::Puppet::Provider::ForemanHttpProxy
  class ForemanHttpProxy < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/http_proxies',
        detailurl: '/api/http_proxies/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', "http_proxy[name]"),
          AttrDefinition.new(:url, 'url', "http_proxy[url]"),
          AttrDefinition.new(:username, 'username', "http_proxy[username]"),
          AttrDefinition.new(:password, 'password', "http_proxy[password]"),
          ForeignKeyArrayAttrDefinition.new(
            :locations,
            'locations',
            "http_proxy[location_ids]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :organizations,
            'organizations',
            "http_proxy[organization_ids]",
            ::Puppet::Provider::ForemanOrganization::ForemanOrganization,
            detailed: true,
          ),
        ],
      )
      @endpoint
    end
  end
end

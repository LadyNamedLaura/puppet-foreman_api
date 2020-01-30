require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_smart_proxy/foreman_smart_proxy'
require 'puppet/provider/foreman_location/foreman_location'
require 'puppet/provider/foreman_organization/foreman_organization'

module ::Puppet::Provider::ForemanRealm
  class ForemanRealm < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/realms',
        detailurl: '/api/realms/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', nil),
          AttrDefinition.new(:name, 'name', "realm[name]"),
          ForeignKeyAttrDefinition.new(
            :realm_proxy,
            'realm_proxy_id',
            "realm[realm_proxy_id]",
            ::Puppet::Provider::ForemanSmartProxy::ForemanSmartProxy,
          ),
          AttrDefinition.new(:realm_type, 'realm_type', "realm[realm_type]"),
          ForeignKeyArrayAttrDefinition.new(
            :locations,
            'locations',
            "realm[location_ids]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :organizations,
            'organizations',
            "realm[organization_ids]",
            ::Puppet::Provider::ForemanOrganization::ForemanOrganization,
            detailed: true,
          ),
        ],
      )
      @endpoint
    end
  end
end

require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_smart_proxy/foreman_smart_proxy'
require 'puppet/provider/foreman_location/foreman_location'
require 'puppet/provider/foreman_organization/foreman_organization'

module ::Puppet::Provider::ForemanDomain
  class ForemanDomain < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/domains',
        detailurl: '/api/domains/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', "domain[name]"),
          AttrDefinition.new(:fullname, 'fullname', "domain[fullname]"),
          ForeignKeyAttrDefinition.new(
            :dns,
            'dns_id',
            "domain[dns_id]",
            ::Puppet::Provider::ForemanSmartProxy::ForemanSmartProxy,
          ),
          AttrDefinition.new(:domain_parameters_attributes, 'domain_parameters_attributes', "domain[domain_parameters_attributes]"),
          ForeignKeyArrayAttrDefinition.new(
            :locations,
            'locations',
            "domain[location_ids]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
            detailed: true,
            wildcardparent: :parent,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :organizations,
            'organizations',
            "domain[organization_ids]",
            ::Puppet::Provider::ForemanOrganization::ForemanOrganization,
            detailed: true,
            wildcardparent: :parent,
          ),
        ],
      )
      @endpoint
    end
  end
end

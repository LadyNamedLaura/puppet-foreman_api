require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_location/foreman_location'
require 'puppet/provider/foreman_organization/foreman_organization'

module ::Puppet::Provider::ForemanEnvironment
  class ForemanEnvironment < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/environments',
        detailurl: '/api/environments/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', "environment[name]"),
          ForeignKeyArrayAttrDefinition.new(
            :locations,
            'locations',
            "environment[location_ids]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
            detailed: true,
            wildcardparent: :parent,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :organizations,
            'organizations',
            "environment[organization_ids]",
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

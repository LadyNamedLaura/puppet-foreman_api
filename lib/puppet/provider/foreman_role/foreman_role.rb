require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_location/foreman_location'
require 'puppet/provider/foreman_organization/foreman_organization'

module ::Puppet::Provider::ForemanRole
  class ForemanRole < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/roles',
        detailurl: '/api/roles/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', "role[name]"),
          AttrDefinition.new(:description, 'description', "role[description]"),
          ForeignKeyArrayAttrDefinition.new(
            :locations,
            'locations',
            "role[location_ids]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :organizations,
            'organizations',
            "role[organization_ids]",
            ::Puppet::Provider::ForemanOrganization::ForemanOrganization,
            detailed: true,
          ),
        ],
      )
      @endpoint
    end
  end
end

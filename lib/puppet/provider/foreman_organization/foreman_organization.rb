require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_location/foreman_location'

module ::Puppet::Provider::ForemanOrganization
  class ForemanOrganization < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/organizations',
        detailurl: '/api/organizations/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', "organization[name]"),
          AttrDefinition.new(:description, 'description', "organization[description]"),
          ForeignKeyAttrDefinition.new(
            :parent,
            'parent_id',
            "organization[parent_id]",
            ::Puppet::Provider::ForemanOrganization::ForemanOrganization,
          ),
          AttrDefinition.new(:ignore_types, 'ignore_types', "organization[ignore_types]"),
          ForeignKeyArrayAttrDefinition.new(
            :locations,
            'locations',
            "organization[location_ids]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
            detailed: true,
            wildcardparent: :parent,
          ),
        ],
      )
      @endpoint
    end
  end
end

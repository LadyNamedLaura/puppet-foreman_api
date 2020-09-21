require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_organization/foreman_organization'

module ::Puppet::Provider::ForemanLocation
  class ForemanLocation < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/locations',
        detailurl: '/api/locations/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', "location[name]"),
          AttrDefinition.new(:description, 'description', "location[description]"),
          ForeignKeyAttrDefinition.new(
            :parent,
            'parent_id',
            "location[parent_id]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
          ),
          AttrDefinition.new(:ignore_types, 'ignore_types', "location[ignore_types]"),
          ForeignKeyArrayAttrDefinition.new(
            :organizations,
            'organizations',
            "location[organization_ids]",
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

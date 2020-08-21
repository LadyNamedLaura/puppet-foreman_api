require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_role/foreman_role'
require 'puppet/provider/foreman_permission/foreman_permission'
require 'puppet/provider/foreman_organization/foreman_organization'
require 'puppet/provider/foreman_location/foreman_location'

module ::Puppet::Provider::ForemanFilter
  class ForemanFilter < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/filters',
        detailurl: '/api/filters/:id',
        composite_namevar: [:role, :resource_type],
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:resource_type, 'resource_type_label', nil),
          ForeignKeyAttrDefinition.new(
            :role,
            'role',
            "filter[role_id]",
            ::Puppet::Provider::ForemanRole::ForemanRole,
          ),
          AttrDefinition.new(:search, 'search', "filter[search]"),
          AttrDefinition.new(:override, 'override', "filter[override]"),
          ForeignKeyArrayAttrDefinition.new(
            :permissions,
            'permissions',
            "filter[permission_ids]",
            ::Puppet::Provider::ForemanPermission::ForemanPermission,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :organizations,
            'organizations',
            "filter[organization_ids]",
            ::Puppet::Provider::ForemanOrganization::ForemanOrganization,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :locations,
            'locations',
            "filter[location_ids]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
            detailed: true,
          ),
        ],
      )
      @endpoint
    end
  end
end

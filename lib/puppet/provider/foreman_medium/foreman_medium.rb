require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_operatingsystem/foreman_operatingsystem'
require 'puppet/provider/foreman_location/foreman_location'
require 'puppet/provider/foreman_organization/foreman_organization'

module ::Puppet::Provider::ForemanMedium
  class ForemanMedium < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/media',
        detailurl: '/api/media/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', "medium[name]"),
          AttrDefinition.new(:path, 'path', "medium[path]"),
          AttrDefinition.new(:os_family, 'os_family', "medium[os_family]"),
          ForeignKeyArrayAttrDefinition.new(
            :operatingsystems,
            'operatingsystems',
            "medium[operatingsystem_ids]",
            ::Puppet::Provider::ForemanOperatingsystem::ForemanOperatingsystem,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :locations,
            'locations',
            "medium[location_ids]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :organizations,
            'organizations',
            "medium[organization_ids]",
            ::Puppet::Provider::ForemanOrganization::ForemanOrganization,
            detailed: true,
          ),
        ],
      )
      @endpoint
    end
  end
end

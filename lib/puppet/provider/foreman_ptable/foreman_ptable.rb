require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_operatingsystem/foreman_operatingsystem'
require 'puppet/provider/foreman_location/foreman_location'
require 'puppet/provider/foreman_organization/foreman_organization'

module ::Puppet::Provider::ForemanPtable
  class ForemanPtable < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/ptables',
        detailurl: '/api/ptables/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', nil),
          AttrDefinition.new(:name, 'name', "ptable[name]"),
          AttrDefinition.new(:layout, 'layout', "ptable[layout]"),
          AttrDefinition.new(:snippet, 'snippet', "ptable[snippet]"),
          AttrDefinition.new(:audit_comment, 'audit_comment', "ptable[audit_comment]"),
          AttrDefinition.new(:locked, 'locked', "ptable[locked]"),
          AttrDefinition.new(:os_family, 'os_family', "ptable[os_family]"),
          ForeignKeyArrayAttrDefinition.new(
            :operatingsystems,
            'operatingsystems',
            "ptable[operatingsystem_ids]",
            ::Puppet::Provider::ForemanOperatingsystem::ForemanOperatingsystem,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :locations,
            'locations',
            "ptable[location_ids]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :organizations,
            'organizations',
            "ptable[organization_ids]",
            ::Puppet::Provider::ForemanOrganization::ForemanOrganization,
            detailed: true,
          ),
        ],
      )
      @endpoint
    end
  end
end

require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_location/foreman_location'
require 'puppet/provider/foreman_organization/foreman_organization'

module ::Puppet::Provider::ForemanReportTemplate
  class ForemanReportTemplate < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/report_templates',
        detailurl: '/api/report_templates/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', "report_template[name]"),
          AttrDefinition.new(:template, 'template', "report_template[template]"),
          AttrDefinition.new(:snippet, 'snippet', "report_template[snippet]"),
          AttrDefinition.new(:audit_comment, 'audit_comment', "report_template[audit_comment]"),
          AttrDefinition.new(:locked, 'locked', "report_template[locked]"),
          AttrDefinition.new(:default, 'default', "report_template[default]"),
          ForeignKeyArrayAttrDefinition.new(
            :locations,
            'locations',
            "report_template[location_ids]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :organizations,
            'organizations',
            "report_template[organization_ids]",
            ::Puppet::Provider::ForemanOrganization::ForemanOrganization,
            detailed: true,
          ),
        ],
      )
      @endpoint
    end
  end
end

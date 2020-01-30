require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_template_kind/foreman_template_kind'
require 'puppet/provider/foreman_operatingsystem/foreman_operatingsystem'
require 'puppet/provider/foreman_location/foreman_location'
require 'puppet/provider/foreman_organization/foreman_organization'

module ::Puppet::Provider::ForemanConfigTemplate
  class ForemanConfigTemplate < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/config_templates',
        detailurl: '/api/config_templates/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', nil),
          AttrDefinition.new(:name, 'name', "config_template[name]"),
          AttrDefinition.new(:template, 'template', "config_template[template]"),
          AttrDefinition.new(:snippet, 'snippet', "config_template[snippet]"),
          AttrDefinition.new(:audit_comment, 'audit_comment', "config_template[audit_comment]"),
          ForeignKeyAttrDefinition.new(
            :template_kind,
            'template_kind_id',
            "config_template[template_kind_id]",
            ::Puppet::Provider::ForemanTemplateKind::ForemanTemplateKind,
          ),
          AttrDefinition.new(:template_combinations_attributes, 'template_combinations_attributes', "config_template[template_combinations_attributes]"),
          ForeignKeyArrayAttrDefinition.new(
            :operatingsystems,
            'operatingsystems',
            "config_template[operatingsystem_ids]",
            ::Puppet::Provider::ForemanOperatingsystem::ForemanOperatingsystem,
            detailed: true,
          ),
          AttrDefinition.new(:locked, 'locked', "config_template[locked]"),
          ForeignKeyArrayAttrDefinition.new(
            :locations,
            'locations',
            "config_template[location_ids]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :organizations,
            'organizations',
            "config_template[organization_ids]",
            ::Puppet::Provider::ForemanOrganization::ForemanOrganization,
            detailed: true,
          ),
        ],
      )
      @endpoint
    end
  end
end

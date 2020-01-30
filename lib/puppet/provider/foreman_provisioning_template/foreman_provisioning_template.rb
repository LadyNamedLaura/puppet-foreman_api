require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_template_kind/foreman_template_kind'
require 'puppet/provider/foreman_operatingsystem/foreman_operatingsystem'
require 'puppet/provider/foreman_location/foreman_location'
require 'puppet/provider/foreman_organization/foreman_organization'

module ::Puppet::Provider::ForemanProvisioningTemplate
  class ForemanProvisioningTemplate < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/provisioning_templates',
        detailurl: '/api/provisioning_templates/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', nil),
          AttrDefinition.new(:name, 'name', "provisioning_template[name]"),
          AttrDefinition.new(:template, 'template', "provisioning_template[template]"),
          AttrDefinition.new(:snippet, 'snippet', "provisioning_template[snippet]"),
          AttrDefinition.new(:audit_comment, 'audit_comment', "provisioning_template[audit_comment]"),
          ForeignKeyAttrDefinition.new(
            :template_kind,
            'template_kind_id',
            "provisioning_template[template_kind_id]",
            ::Puppet::Provider::ForemanTemplateKind::ForemanTemplateKind,
          ),
          AttrDefinition.new(:template_combinations_attributes, 'template_combinations_attributes', "provisioning_template[template_combinations_attributes]"),
          ForeignKeyArrayAttrDefinition.new(
            :operatingsystems,
            'operatingsystems',
            "provisioning_template[operatingsystem_ids]",
            ::Puppet::Provider::ForemanOperatingsystem::ForemanOperatingsystem,
            detailed: true,
          ),
          AttrDefinition.new(:locked, 'locked', "provisioning_template[locked]"),
          ForeignKeyArrayAttrDefinition.new(
            :locations,
            'locations',
            "provisioning_template[location_ids]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :organizations,
            'organizations',
            "provisioning_template[organization_ids]",
            ::Puppet::Provider::ForemanOrganization::ForemanOrganization,
            detailed: true,
          ),
        ],
      )
      @endpoint
    end
  end
end

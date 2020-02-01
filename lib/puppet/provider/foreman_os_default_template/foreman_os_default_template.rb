require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_operatingsystem/foreman_operatingsystem'
require 'puppet/provider/foreman_template_kind/foreman_template_kind'
require 'puppet/provider/foreman_config_template/foreman_config_template'
require 'puppet/provider/foreman_provisioning_template/foreman_provisioning_template'

module ::Puppet::Provider::ForemanOsDefaultTemplate
  class ForemanOsDefaultTemplate < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/operatingsystems/:operatingsystem_id/os_default_templates',
        detailurl: '/api/operatingsystems/:operatingsystem_id/os_default_templates/:id',
        composite_namevar: [:operatingsystem, :template_kind],
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          ForeignKeyAttrDefinition.new(
            :operatingsystem,
            'operatingsystem_id',
            "operatingsystem_id",
            ::Puppet::Provider::ForemanOperatingsystem::ForemanOperatingsystem,
          ),
          ForeignKeyAttrDefinition.new(
            :template_kind,
            'template_kind_id',
            "os_default_template[template_kind_id]",
            ::Puppet::Provider::ForemanTemplateKind::ForemanTemplateKind,
          ),
          ForeignKeyAttrDefinition.new(
            :config_template,
            'config_template_id',
            "os_default_template[config_template_id]",
            ::Puppet::Provider::ForemanConfigTemplate::ForemanConfigTemplate,
          ),
          ForeignKeyAttrDefinition.new(
            :provisioning_template,
            'provisioning_template_id',
            "os_default_template[provisioning_template_id]",
            ::Puppet::Provider::ForemanProvisioningTemplate::ForemanProvisioningTemplate,
          ),
        ],
      )
      @endpoint
    end
  end
end

require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_config_template/foreman_config_template'
require 'puppet/provider/foreman_provisioning_template/foreman_provisioning_template'
require 'puppet/provider/foreman_hostgroup/foreman_hostgroup'
require 'puppet/provider/foreman_environment/foreman_environment'

module ::Puppet::Provider::ForemanTemplateCombination
  class ForemanTemplateCombination < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/config_templates/:config_template_id/template_combinations',
        detailurl: '/api/template_combinations/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          ForeignKeyAttrDefinition.new(
            :config_template,
            'config_template_id',
            "config_template_id",
            ::Puppet::Provider::ForemanConfigTemplate::ForemanConfigTemplate,
          ),
          ForeignKeyAttrDefinition.new(
            :provisioning_template,
            'provisioning_template_id',
            "provisioning_template_id",
            ::Puppet::Provider::ForemanProvisioningTemplate::ForemanProvisioningTemplate,
          ),
          ForeignKeyAttrDefinition.new(
            :hostgroup,
            'hostgroup_id',
            "template_combination[hostgroup_id]",
            ::Puppet::Provider::ForemanHostgroup::ForemanHostgroup,
          ),
          ForeignKeyAttrDefinition.new(
            :environment,
            'environment_id',
            "template_combination[environment_id]",
            ::Puppet::Provider::ForemanEnvironment::ForemanEnvironment,
          ),
        ],
      )
      @endpoint
    end
  end
end

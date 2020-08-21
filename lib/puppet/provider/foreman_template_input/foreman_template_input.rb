require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_config_template/foreman_config_template'

module ::Puppet::Provider::ForemanTemplateInput
  class ForemanTemplateInput < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/templates/:template_id/template_inputs',
        detailurl: '/api/templates/:template_id/template_inputs/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          ForeignKeyAttrDefinition.new(
            :template,
            'template_id',
            "template_id",
            ::Puppet::Provider::ForemanConfigTemplate::ForemanConfigTemplate,
          ),
          AttrDefinition.new(:name, 'name', "template_input[name]"),
          AttrDefinition.new(:description, 'description', "template_input[description]"),
          AttrDefinition.new(:required, 'required', "template_input[required]"),
          AttrDefinition.new(:advanced, 'advanced', "template_input[advanced]"),
          AttrDefinition.new(:input_type, 'input_type', "template_input[input_type]"),
          AttrDefinition.new(:fact_name, 'fact_name', "template_input[fact_name]"),
          AttrDefinition.new(:variable_name, 'variable_name', "template_input[variable_name]"),
          AttrDefinition.new(:puppet_class_name, 'puppet_class_name', "template_input[puppet_class_name]"),
          AttrDefinition.new(:puppet_parameter_name, 'puppet_parameter_name', "template_input[puppet_parameter_name]"),
          AttrDefinition.new(:options, 'options', "template_input[options]"),
          AttrDefinition.new(:default, 'default', "template_input[default]"),
          AttrDefinition.new(:hidden_value, 'hidden_value', "template_input[hidden_value]"),
          AttrDefinition.new(:value_type, 'value_type', "template_input[value_type]"),
          AttrDefinition.new(:resource_type, 'resource_type', "template_input[resource_type]"),
        ],
      )
      @endpoint
    end
  end
end

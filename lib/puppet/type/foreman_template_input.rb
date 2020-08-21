require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_template_input',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Template inputs
    EOS
  attributes: {
    ensure: {
      type:    'Enum[present, absent]',
      desc:    'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },
    id: {
      type:      "Integer",
      desc:      "internal numerical id",
      behaviour: :read_only,
    },
    template: {
      type:      "Variant[String,Integer]",
      desc:      "",
    },
    name: {
      type:      "String",
      desc:      "Input name",
      behaviour: :namevar,
    },
    description: {
      type:      "Optional[String]",
      desc:      "Input description",
    },
    required: {
      type:      "Optional[Boolean]",
      desc:      "Input is required",
    },
    advanced: {
      type:      "Optional[Boolean]",
      desc:      "Input is advanced",
    },
    input_type: {
      type:      "String",
      desc:      "Input type",
    },
    fact_name: {
      type:      "Optional[String]",
      desc:      "Fact name, used when input type is fact",
    },
    variable_name: {
      type:      "Optional[String]",
      desc:      "Variable name, used when input type is variable",
    },
    puppet_class_name: {
      type:      "Optional[String]",
      desc:      "Puppet class name, used when input type is puppet_parameter",
    },
    puppet_parameter_name: {
      type:      "Optional[String]",
      desc:      "Puppet parameter name, used when input type is puppet_parameter",
    },
    options: {
      type:      "Optional[Array]",
      desc:      "Selectable values for user inputs",
    },
    default: {
      type:      "Optional[String]",
      desc:      "Default value for user input",
    },
    hidden_value: {
      type:      "Optional[Boolean]",
      desc:      "<p>The value contains sensitive information and shouldn not be normally\nvisible, useful e.g. for passwords</p>",
    },
    value_type: {
      type:      "Optional[String]",
      desc:      "Value type, defaults to plain",
    },
    resource_type: {
      type:      "Optional[String]",
      desc:      "For values of type search, this is the resource the value searches in",
    },
  }

)

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_template_combination',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Template combinations
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
    config_template: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "ID of config template",
    },
    provisioning_template: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "ID of config template",
    },
    hostgroup: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "host group id",
    },
    environment: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "environment id",
    },
  }

)

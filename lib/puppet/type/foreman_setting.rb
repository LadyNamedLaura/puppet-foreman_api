require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_setting',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Settings
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
    name: {
      type:      "String",
      desc:      "name",
      behaviour: :namevar,
    },
    value: {
      type:      "Data",
      desc:      "",
    },
  }

)

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_usergroup',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Usergroups
    EOS
  features: ['canonicalize'],
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
      desc:      "",
      behaviour: :namevar,
    },
    admin: {
      type:      "Optional[Boolean]",
      desc:      "is an admin user group",
    },
    users: {
      type:      "Optional[Array[Variant[String,Integer]]]",
      desc:      "",
    },
    usergroups: {
      type:      "Optional[Array[Variant[String,Integer]]]",
      desc:      "",
    },
    roles: {
      type:      "Optional[Array[Variant[String,Integer]]]",
      desc:      "",
    },
  }

)

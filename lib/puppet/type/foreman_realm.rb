require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_realm',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Realms
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
      desc:      "The realm name, e.g. EXAMPLE.COM",
      behaviour: :namevar,
    },
    realm_proxy: {
      type:      "Variant[String,Integer]",
      desc:      "Proxy ID to use within this realm",
    },
    realm_type: {
      type:      "String",
      desc:      "Realm type, e.g. FreeIPA or Active Directory",
    },
    locations: {
      type:      "Optional[Array[Variant[String,Integer]]]",
      desc:      "REPLACE locations with given ids",
    },
    organizations: {
      type:      "Optional[Array[Variant[String,Integer]]]",
      desc:      "REPLACE organizations with given ids.",
    },
  }

)

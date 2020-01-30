require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_http_proxy',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Http proxies
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
      desc:      "The HTTP Proxy name",
      behaviour: :namevar,
    },
    url: {
      type:      "String",
      desc:      "URL of the HTTP Proxy",
    },
    username: {
      type:      "Optional[String]",
      desc:      "Username used to authenticate with the HTTP Proxy",
    },
    password: {
      type:      "Optional[String]",
      desc:      "Password used to authenticate with the HTTP Proxy",
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

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_domain',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Domains
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
      desc:      "The full DNS domain name",
      behaviour: :namevar,
    },
    fullname: {
      type:      "Optional[String]",
      desc:      "Description of the domain",
    },
    dns: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "DNS proxy ID to use within this domain",
    },
    domain_parameters_attributes: {
      type:      "Optional[Array]",
      desc:      "Array of parameters (name, value)",
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

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_operatingsystem',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Operating systems
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
    major: {
      type:      "String",
      desc:      "",
    },
    minor: {
      type:      "Optional[String]",
      desc:      "",
    },
    description: {
      type:      "Optional[String]",
      desc:      "",
    },
    family: {
      type:      "Optional[String]",
      desc:      "",
    },
    release_name: {
      type:      "Optional[String]",
      desc:      "",
    },
    os_parameters_attributes: {
      type:      "Optional[Array]",
      desc:      "Array of parameters",
    },
    password_hash: {
      type:      "Optional[String]",
      desc:      "Root password hash function to use",
    },
    architectures: {
      type:      "Optional[Array[Variant[String,Integer]]]",
      desc:      "IDs of associated architectures",
    },
    provisioning_templates: {
      type:      "Optional[Array[Variant[String,Integer]]]",
      desc:      "IDs of associated provisioning templates",
    },
    media: {
      type:      "Optional[Array[Variant[String,Integer]]]",
      desc:      "IDs of associated media",
    },
    ptables: {
      type:      "Optional[Array[Variant[String,Integer]]]",
      desc:      "IDs of associated partition tables",
    },
  }

)

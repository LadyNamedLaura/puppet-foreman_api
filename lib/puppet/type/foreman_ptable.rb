require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_ptable',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Ptables
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
    description: {
      type:      "Optional[String]",
      desc:      "",
    },
    layout: {
      type:      "String",
      desc:      "",
    },
    snippet: {
      type:      "Optional[Boolean]",
      desc:      "",
    },
    audit_comment: {
      type:      "Optional[String]",
      desc:      "",
    },
    locked: {
      type:      "Optional[Boolean]",
      desc:      "Whether or not the template is locked for editing",
    },
    os_family: {
      type:      "Optional[String]",
      desc:      "",
    },
    operatingsystems: {
      type:      "Optional[Array[Variant[String,Integer]]]",
      desc:      "Array of operating system IDs to associate with the partition table",
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

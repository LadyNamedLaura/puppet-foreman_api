require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_location',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Locations
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
      desc:      "",
      behaviour: :namevar,
    },
    description: {
      type:      "Optional[String]",
      desc:      "",
    },
    parent: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "Parent ID",
    },
    ignore_types: {
      type:      "Optional[Array]",
      desc:      "List of resources types that will be automatically associated",
    },
  }

)

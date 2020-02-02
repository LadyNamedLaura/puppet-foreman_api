require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_filter',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Filters
    EOS
  title_patterns: [
    {
      pattern: %r{^(?<role>.*[^/])/(?<_permissions>.*[^/])$},
    },
  ],
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
    _permissions: {
      type:      "Data",
      desc:      "",
      behaviour: :namevar,
    },
    role: {
      type:      "Variant[String,Integer]",
      desc:      "",
      behaviour: :namevar,
    },
    search: {
      type:      "Optional[String]",
      desc:      "",
    },
    override: {
      type:      "Optional[Boolean]",
      desc:      "",
    },
    permissions: {
      type:      "Optional[Array[Variant[String,Integer]]]",
      desc:      "",
    },
    organizations: {
      type:      "Optional[Array[Variant[String,Integer]]]",
      desc:      "",
    },
    locations: {
      type:      "Optional[Array[Variant[String,Integer]]]",
      desc:      "",
    },
  }

)

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_filter',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Filters
    EOS
  title_patterns: [
    {
      pattern: %r{^(?<role>.*[^/])/(?<resource_type>.*[^/])$},
    },
  ],
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
    resource_type: {
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
  }

)

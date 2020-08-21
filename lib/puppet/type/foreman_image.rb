require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_image',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Images
    EOS
  title_patterns: [
    {
      pattern: %r{^(?<compute_resource>.*[^/])/(?<name>.*[^/])$},
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
    compute_resource: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "ID of compute resource",
      behaviour: :namevar,
    },
    name: {
      type:      "String",
      desc:      "",
      behaviour: :namevar,
    },
    username: {
      type:      "String",
      desc:      "",
    },
    uuid: {
      type:      "String",
      desc:      "Template ID in the compute resource",
    },
    password: {
      type:      "Optional[String]",
      desc:      "",
    },
    architecture: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "ID of architecture",
    },
    operatingsystem: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "ID of operating system",
    },
    user_data: {
      type:      "Optional[Boolean]",
      desc:      "Whether or not the image supports user data",
    },
  }

)

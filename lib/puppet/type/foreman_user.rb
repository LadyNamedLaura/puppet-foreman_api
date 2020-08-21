require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_user',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Users
    EOS
  title_patterns: [
    {
      pattern: %r{^(?<login>.*[^/])$},
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
    login: {
      type:      "String",
      desc:      "",
      behaviour: :namevar,
    },
    firstname: {
      type:      "Optional[String]",
      desc:      "",
    },
    lastname: {
      type:      "Optional[String]",
      desc:      "",
    },
    mail: {
      type:      "String",
      desc:      "",
    },
    description: {
      type:      "Optional[String]",
      desc:      "",
    },
    admin: {
      type:      "Optional[Boolean]",
      desc:      "is an admin account",
    },
    password: {
      type:      "Optional[String]",
      desc:      "Required unless user is in an external authentication source",
    },
    default_location: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "",
    },
    default_organization: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "",
    },
    timezone: {
      type:      "Optional[String]",
      desc:      "User&#39;s timezone",
    },
    locale: {
      type:      "Optional[String]",
      desc:      "User&#39;s preferred locale",
    },
    roles: {
      type:      "Optional[Array[Variant[String,Integer]]]",
      desc:      "",
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

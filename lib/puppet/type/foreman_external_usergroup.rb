require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_external_usergroup',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman External usergroups
    EOS
  title_patterns: [
    {
      pattern: %r{^(?<usergroup>.*[^/])/(?<ldapname>.*[^/])$},
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
    usergroup: {
      type:      "Variant[String,Integer]",
      desc:      "ID or name of user group",
      behaviour: :namevar,
    },
    ldapname: {
      type:      "String",
      desc:      "External user group name",
      behaviour: :namevar,
    },
    auth_source: {
      type:      "Variant[String,Integer]",
      desc:      "ID of linked authentication source",
    },
  }

)

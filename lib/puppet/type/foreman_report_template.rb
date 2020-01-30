require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_report_template',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Report templates
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
    template: {
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
    default: {
      type:      "Optional[Boolean]",
      desc:      "<p>Whether or not the template is added automatically to new organizations and\nlocations</p>",
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

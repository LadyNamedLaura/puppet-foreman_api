require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_provisioning_template',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Provisioning templates
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
      desc:      "template name",
      behaviour: :namevar,
    },
    description: {
      type:      "Optional[String]",
      desc:      "",
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
    template_kind: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "not relevant for snippet",
    },
    template_combinations_attributes: {
      type:      "Optional[Array]",
      desc:      "Array of template combinations (hostgroup_id, environment_id)",
    },
    operatingsystems: {
      type:      "Optional[Array[Variant[String,Integer]]]",
      desc:      "Array of operating system IDs to associate with the template",
    },
    locked: {
      type:      "Optional[Boolean]",
      desc:      "Whether or not the template is locked for editing",
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

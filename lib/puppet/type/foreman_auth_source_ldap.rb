require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_auth_source_ldap',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Auth source ldaps
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
    host: {
      type:      "String",
      desc:      "",
    },
    port: {
      type:      "Optional[Numeric]",
      desc:      "defaults to 389",
    },
    account: {
      type:      "Optional[String]",
      desc:      "",
    },
    base_dn: {
      type:      "Optional[String]",
      desc:      "",
    },
    account_password: {
      type:      "Optional[String]",
      desc:      "required if onthefly_register is true",
      behaviour: :parameter,
    },
    attr_login: {
      type:      "Optional[String]",
      desc:      "required if onthefly_register is true",
    },
    attr_firstname: {
      type:      "Optional[String]",
      desc:      "required if onthefly_register is true",
    },
    attr_lastname: {
      type:      "Optional[String]",
      desc:      "required if onthefly_register is true",
    },
    attr_mail: {
      type:      "Optional[String]",
      desc:      "required if onthefly_register is true",
    },
    attr_photo: {
      type:      "Optional[String]",
      desc:      "",
    },
    onthefly_register: {
      type:      "Optional[Boolean]",
      desc:      "",
    },
    usergroup_sync: {
      type:      "Optional[Boolean]",
      desc:      "sync external user groups on login",
    },
    tls: {
      type:      "Optional[Boolean]",
      desc:      "",
    },
    groups_base: {
      type:      "Optional[String]",
      desc:      "groups base DN",
    },
    use_netgroups: {
      type:      "Optional[Boolean]",
      desc:      "<p>use NIS netgroups instead of posix groups, applicable only when server_type\nis posix or free_ipa</p>",
    },
    server_type: {
      type:      "Optional[String]",
      desc:      "type of the LDAP server",
    },
    ldap_filter: {
      type:      "Optional[String]",
      desc:      "LDAP filter",
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

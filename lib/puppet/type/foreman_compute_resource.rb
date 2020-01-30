require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_compute_resource',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Compute resources
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
    compute_provider: {
      type:      "Optional[String]",
      desc:      "Providers include",
    },
    url: {
      type:      "Optional[String]",
      desc:      "URL for Libvirt, oVirt, OpenStack and Rackspace",
    },
    description: {
      type:      "Optional[String]",
      desc:      "",
    },
    user: {
      type:      "Optional[String]",
      desc:      "Username for oVirt, EC2, VMware, OpenStack. Access Key for EC2.",
    },
    password: {
      type:      "Optional[String]",
      desc:      "Password for oVirt, EC2, VMware, OpenStack. Secret key for EC2",
      behaviour: :init_only,
    },
    datacenter: {
      type:      "Optional[String]",
      desc:      "for oVirt, VMware Datacenter",
    },
    use_v4: {
      type:      "Optional[Boolean]",
      desc:      "for oVirt only",
    },
    ovirt_quota: {
      type:      "Optional[String]",
      desc:      "for oVirt only, ID of quota to use",
    },
    public_key: {
      type:      "Optional[String]",
      desc:      "for oVirt only",
    },
    region: {
      type:      "Optional[String]",
      desc:      "for EC2 only, use &#39;us-gov-west-1&#39; for GovCloud region",
    },
    tenant: {
      type:      "Optional[String]",
      desc:      "for OpenStack only",
    },
    domain: {
      type:      "Optional[String]",
      desc:      "for OpenStack only",
    },
    server: {
      type:      "Optional[String]",
      desc:      "for VMware",
    },
    set_console_password: {
      type:      "Optional[Boolean]",
      desc:      "for Libvirt and VMware only",
    },
    display_type: {
      type:      "Optional[String]",
      desc:      "for Libvirt only",
    },
    caching_enabled: {
      type:      "Optional[Boolean]",
      desc:      "enable caching, for VMware only",
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

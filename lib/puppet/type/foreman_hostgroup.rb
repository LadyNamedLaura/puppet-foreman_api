require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_hostgroup',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Hostgroups
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
      desc:      "Name of the host group",
      behaviour: :namevar,
    },
    description: {
      type:      "Optional[String]",
      desc:      "Host group description",
    },
    parent: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "Parent ID of the host group",
    },
    environment: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "Environment ID",
    },
    compute_profile: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "Compute profile ID",
    },
    compute_resource: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "Compute resource ID",
    },
    operatingsystem: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "Operating system ID",
    },
    architecture: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "Architecture ID",
    },
    pxe_loader: {
      type:      "Optional[String]",
      desc:      "DHCP filename option (Grub2/PXELinux by default)",
    },
    medium: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "Media ID",
    },
    ptable: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "Partition table ID",
    },
    subnet: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "Subnet ID",
    },
    subnet6: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "Subnet IPv6 ID",
    },
    domain: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "Domain ID",
    },
    realm: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "Realm ID",
    },
    group_parameters_attributes: {
      type:      "Optional[Array]",
      desc:      "Array of parameters",
    },
    puppet_proxy: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "Puppet proxy ID",
    },
    puppet_ca_proxy: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "Puppet CA proxy ID",
    },
    root_pass: {
      type:      "Optional[String]",
      desc:      "Root password on provisioned hosts",
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

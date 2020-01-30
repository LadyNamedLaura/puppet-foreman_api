require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_subnet',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Subnets
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
      desc:      "Subnet name",
      behaviour: :namevar,
    },
    description: {
      type:      "Optional[String]",
      desc:      "Subnet description",
    },
    network_type: {
      type:      "Optional[String]",
      desc:      "Type or protocol, IPv4 or IPv6, defaults to IPv4",
    },
    network: {
      type:      "String",
      desc:      "Subnet network",
    },
    mask: {
      type:      "String",
      desc:      "Netmask for this subnet",
    },
    gateway: {
      type:      "Optional[String]",
      desc:      "Subnet gateway",
    },
    dns_primary: {
      type:      "Optional[String]",
      desc:      "Primary DNS for this subnet",
    },
    dns_secondary: {
      type:      "Optional[String]",
      desc:      "Secondary DNS for this subnet",
    },
    ipam: {
      type:      "Optional[String]",
      desc:      "<p>IP Address auto suggestion mode for this subnet, valid values are “DHCP”,\n“Internal DB”, “None”</p>",
    },
    from: {
      type:      "Optional[String]",
      desc:      "Starting IP Address for IP auto suggestion",
    },
    to: {
      type:      "Optional[String]",
      desc:      "Ending IP Address for IP auto suggestion",
    },
    vlanid: {
      type:      "Optional[Numeric]",
      desc:      "VLAN ID for this subnet",
    },
    mtu: {
      type:      "Optional[Numeric]",
      desc:      "MTU for this subnet",
    },
    domains: {
      type:      "Optional[Array[Variant[String,Integer]]]",
      desc:      "Domains in which this subnet is part",
    },
    dhcp: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "DHCP Proxy ID to use within this subnet",
    },
    tftp: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "TFTP Proxy ID to use within this subnet",
    },
    httpboot: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "HTTPBoot Proxy ID to use within this subnet",
    },
    dns: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "DNS Proxy ID to use within this subnet",
    },
    template: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "Template HTTP(S) Proxy ID to use within this subnet",
    },
    boot_mode: {
      type:      "Optional[String]",
      desc:      "<p>Default boot mode for interfaces assigned to this subnet, valid values are\n“Static”, “DHCP”</p>",
    },
    subnet_parameters_attributes: {
      type:      "Optional[Array]",
      desc:      "Array of parameters (name, value)",
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

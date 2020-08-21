require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_compute_resource',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Compute resources
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
    compute_provider: {
      type:      "Optional[String]",
      desc:      "Providers include Vmware",
    },
    url: {
      type:      "Optional[String]",
      desc:      "URL for Libvirt, oVirt and OpenStack",
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
      behaviour: :parameter,
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
      desc:      "for oVirt only, ID or Name of quota to use",
    },
    public_key: {
      type:      "Optional[String]",
      desc:      "for oVirt only",
    },
    region: {
      type:      "Optional[String]",
      desc:      "<p>for AzureRm eg. &#39;eastus&#39; and for EC2 only. Use\n&#39;us-gov-west-1&#39; for EC2 GovCloud region</p>",
    },
    tenant: {
      type:      "Optional[String]",
      desc:      "for OpenStack and AzureRm only",
    },
    domain: {
      type:      "Optional[String]",
      desc:      "for OpenStack (v3) only",
    },
    project_domain_name: {
      type:      "Optional[String]",
      desc:      "for OpenStack (v3) only",
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
      desc:      "for Libvirt and oVirt only",
    },
    keyboard_layout: {
      type:      "Optional[String]",
      desc:      "for oVirt only",
    },
    caching_enabled: {
      type:      "Optional[Boolean]",
      desc:      "enable caching, for VMware only",
    },
    project: {
      type:      "Optional[String]",
      desc:      "Project id for GCE only",
    },
    email: {
      type:      "Optional[String]",
      desc:      "Email for GCE only",
    },
    key_path: {
      type:      "Optional[String]",
      desc:      "Certificate path for GCE only",
    },
    zone: {
      type:      "Optional[String]",
      desc:      "for GCE only",
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

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_medium',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Media
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
      desc:      "Name of media",
      behaviour: :namevar,
    },
    path: {
      type:      "String",
      desc:      "<p>The path to the medium, can be a URL or a valid NFS server (exclusive of\nthe architecture).</p>\n\n<p>for example <a\nhref=\"http://mirror.centos.org/centos/$version/os/$arch\">mirror.centos.org/centos/$version/os/$arch</a>\nwhere $arch will be substituted for the host&#39;s actual OS architecture\nand $version, $major and $minor will be substituted for the version of the\noperating system.</p>\n\nSolaris and Debian media may also use $release.",
    },
    os_family: {
      type:      "Optional[String]",
      desc:      "<p>Operating system family, available values: AIX, Altlinux, Archlinux,\nCoreos, Debian, Freebsd, Gentoo, Junos, NXOS, Rancheros, Redhat, Solaris,\nSuse, VRP, Windows, Xenserver</p>",
    },
    operatingsystems: {
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

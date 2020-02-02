require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_compute_attribute',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Compute attributes
    EOS
  title_patterns: [
    {
      pattern: %r{^(?<compute_resource>.*[^/])/(?<compute_profile>.*[^/])$},
    },
  ],
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
    compute_profile: {
      type:      "Variant[String,Integer]",
      desc:      "",
      behaviour: :namevar,
    },
    compute_resource: {
      type:      "Variant[String,Integer]",
      desc:      "",
      behaviour: :namevar,
    },
    vm_attrs: {
      type:      "Hash",
      desc:      "",
    },
  }

)

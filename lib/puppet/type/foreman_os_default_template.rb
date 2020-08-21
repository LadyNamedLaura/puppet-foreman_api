require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'foreman_os_default_template',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage foreman Os default templates
    EOS
  title_patterns: [
    {
      pattern: %r{^(?<operatingsystem>.*[^/])/(?<template_kind>.*[^/])$},
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
    operatingsystem: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "ID of operating system",
      behaviour: :namevar,
    },
    template_kind: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "",
      behaviour: :namevar,
    },
    provisioning_template: {
      type:      "Optional[Variant[String,Integer]]",
      desc:      "ID of provisioning template",
    },
  }

)

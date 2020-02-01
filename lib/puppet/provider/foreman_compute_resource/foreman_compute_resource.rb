require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_location/foreman_location'
require 'puppet/provider/foreman_organization/foreman_organization'

module ::Puppet::Provider::ForemanComputeResource
  class ForemanComputeResource < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/compute_resources',
        detailurl: '/api/compute_resources/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', "compute_resource[name]"),
          AttrDefinition.new(:compute_provider, 'provider', "compute_resource[provider]"),
          AttrDefinition.new(:url, 'url', "compute_resource[url]"),
          AttrDefinition.new(:description, 'description', "compute_resource[description]"),
          AttrDefinition.new(:user, 'user', "compute_resource[user]"),
          AttrDefinition.new(:password, 'password', "compute_resource[password]"),
          AttrDefinition.new(:datacenter, 'datacenter', "compute_resource[datacenter]"),
          AttrDefinition.new(:use_v4, 'use_v4', "compute_resource[use_v4]"),
          AttrDefinition.new(:ovirt_quota, 'ovirt_quota', "compute_resource[ovirt_quota]"),
          AttrDefinition.new(:public_key, 'public_key', "compute_resource[public_key]"),
          AttrDefinition.new(:region, 'region', "compute_resource[region]"),
          AttrDefinition.new(:tenant, 'tenant', "compute_resource[tenant]"),
          AttrDefinition.new(:domain, 'domain', "compute_resource[domain]"),
          AttrDefinition.new(:server, 'server', "compute_resource[server]"),
          AttrDefinition.new(:set_console_password, 'set_console_password', "compute_resource[set_console_password]"),
          AttrDefinition.new(:display_type, 'display_type', "compute_resource[display_type]"),
          AttrDefinition.new(:caching_enabled, 'caching_enabled', "compute_resource[caching_enabled]"),
          ForeignKeyArrayAttrDefinition.new(
            :locations,
            'locations',
            "compute_resource[location_ids]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :organizations,
            'organizations',
            "compute_resource[organization_ids]",
            ::Puppet::Provider::ForemanOrganization::ForemanOrganization,
            detailed: true,
          ),
        ],
      )
      @endpoint
    end
  end
end

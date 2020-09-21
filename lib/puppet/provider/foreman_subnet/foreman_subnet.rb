require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_domain/foreman_domain'
require 'puppet/provider/foreman_smart_proxy/foreman_smart_proxy'
require 'puppet/provider/foreman_smart_proxy/foreman_smart_proxy'
require 'puppet/provider/foreman_smart_proxy/foreman_smart_proxy'
require 'puppet/provider/foreman_smart_proxy/foreman_smart_proxy'
require 'puppet/provider/foreman_smart_proxy/foreman_smart_proxy'
require 'puppet/provider/foreman_smart_proxy/foreman_smart_proxy'
require 'puppet/provider/foreman_smart_proxy/foreman_smart_proxy'
require 'puppet/provider/foreman_location/foreman_location'
require 'puppet/provider/foreman_organization/foreman_organization'

module ::Puppet::Provider::ForemanSubnet
  class ForemanSubnet < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/subnets',
        detailurl: '/api/subnets/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', "subnet[name]"),
          AttrDefinition.new(:description, 'description', "subnet[description]"),
          AttrDefinition.new(:network_type, 'network_type', "subnet[network_type]"),
          AttrDefinition.new(:network, 'network', "subnet[network]"),
          AttrDefinition.new(:cidr, 'cidr', "subnet[cidr]"),
          AttrDefinition.new(:mask, 'mask', "subnet[mask]"),
          AttrDefinition.new(:gateway, 'gateway', "subnet[gateway]"),
          AttrDefinition.new(:dns_primary, 'dns_primary', "subnet[dns_primary]"),
          AttrDefinition.new(:dns_secondary, 'dns_secondary', "subnet[dns_secondary]"),
          AttrDefinition.new(:ipam, 'ipam', "subnet[ipam]"),
          AttrDefinition.new(:from, 'from', "subnet[from]"),
          AttrDefinition.new(:to, 'to', "subnet[to]"),
          AttrDefinition.new(:vlanid, 'vlanid', "subnet[vlanid]"),
          AttrDefinition.new(:mtu, 'mtu', "subnet[mtu]"),
          ForeignKeyArrayAttrDefinition.new(
            :domains,
            'domains',
            "subnet[domain_ids]",
            ::Puppet::Provider::ForemanDomain::ForemanDomain,
            detailed: true,
          ),
          ForeignKeyAttrDefinition.new(
            :dhcp,
            'dhcp_id',
            "subnet[dhcp_id]",
            ::Puppet::Provider::ForemanSmartProxy::ForemanSmartProxy,
          ),
          ForeignKeyAttrDefinition.new(
            :tftp,
            'tftp_id',
            "subnet[tftp_id]",
            ::Puppet::Provider::ForemanSmartProxy::ForemanSmartProxy,
          ),
          ForeignKeyAttrDefinition.new(
            :httpboot,
            'httpboot_id',
            "subnet[httpboot_id]",
            ::Puppet::Provider::ForemanSmartProxy::ForemanSmartProxy,
          ),
          ForeignKeyAttrDefinition.new(
            :externalipam,
            'externalipam_id',
            "subnet[externalipam_id]",
            ::Puppet::Provider::ForemanSmartProxy::ForemanSmartProxy,
          ),
          ForeignKeyAttrDefinition.new(
            :dns,
            'dns_id',
            "subnet[dns_id]",
            ::Puppet::Provider::ForemanSmartProxy::ForemanSmartProxy,
          ),
          ForeignKeyAttrDefinition.new(
            :template,
            'template_id',
            "subnet[template_id]",
            ::Puppet::Provider::ForemanSmartProxy::ForemanSmartProxy,
          ),
          ForeignKeyAttrDefinition.new(
            :discovery,
            'discovery_id',
            "subnet[discovery_id]",
            ::Puppet::Provider::ForemanSmartProxy::ForemanSmartProxy,
          ),
          AttrDefinition.new(:boot_mode, 'boot_mode', "subnet[boot_mode]"),
          AttrDefinition.new(:subnet_parameters_attributes, 'subnet_parameters_attributes', "subnet[subnet_parameters_attributes]"),
          ForeignKeyArrayAttrDefinition.new(
            :locations,
            'locations',
            "subnet[location_ids]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
            detailed: true,
            wildcardparent: :parent,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :organizations,
            'organizations',
            "subnet[organization_ids]",
            ::Puppet::Provider::ForemanOrganization::ForemanOrganization,
            detailed: true,
            wildcardparent: :parent,
          ),
        ],
      )
      @endpoint
    end
  end
end

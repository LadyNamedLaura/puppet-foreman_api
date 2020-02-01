require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_environment/foreman_environment'
require 'puppet/provider/foreman_compute_profile/foreman_compute_profile'
require 'puppet/provider/foreman_compute_resource/foreman_compute_resource'
require 'puppet/provider/foreman_operatingsystem/foreman_operatingsystem'
require 'puppet/provider/foreman_architecture/foreman_architecture'
require 'puppet/provider/foreman_medium/foreman_medium'
require 'puppet/provider/foreman_ptable/foreman_ptable'
require 'puppet/provider/foreman_subnet/foreman_subnet'
require 'puppet/provider/foreman_subnet/foreman_subnet'
require 'puppet/provider/foreman_domain/foreman_domain'
require 'puppet/provider/foreman_realm/foreman_realm'
require 'puppet/provider/foreman_smart_proxy/foreman_smart_proxy'
require 'puppet/provider/foreman_smart_proxy/foreman_smart_proxy'
require 'puppet/provider/foreman_location/foreman_location'
require 'puppet/provider/foreman_organization/foreman_organization'

module ::Puppet::Provider::ForemanHostgroup
  class ForemanHostgroup < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/hostgroups',
        detailurl: '/api/hostgroups/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', "hostgroup[name]"),
          AttrDefinition.new(:description, 'description', "hostgroup[description]"),
          ForeignKeyAttrDefinition.new(
            :parent,
            'parent_id',
            "hostgroup[parent_id]",
            ::Puppet::Provider::ForemanHostgroup::ForemanHostgroup,
          ),
          ForeignKeyAttrDefinition.new(
            :environment,
            'environment_id',
            "hostgroup[environment_id]",
            ::Puppet::Provider::ForemanEnvironment::ForemanEnvironment,
          ),
          ForeignKeyAttrDefinition.new(
            :compute_profile,
            'compute_profile_id',
            "hostgroup[compute_profile_id]",
            ::Puppet::Provider::ForemanComputeProfile::ForemanComputeProfile,
          ),
          ForeignKeyAttrDefinition.new(
            :compute_resource,
            'compute_resource_id',
            "hostgroup[compute_resource_id]",
            ::Puppet::Provider::ForemanComputeResource::ForemanComputeResource,
          ),
          ForeignKeyAttrDefinition.new(
            :operatingsystem,
            'operatingsystem_id',
            "hostgroup[operatingsystem_id]",
            ::Puppet::Provider::ForemanOperatingsystem::ForemanOperatingsystem,
          ),
          ForeignKeyAttrDefinition.new(
            :architecture,
            'architecture_id',
            "hostgroup[architecture_id]",
            ::Puppet::Provider::ForemanArchitecture::ForemanArchitecture,
          ),
          AttrDefinition.new(:pxe_loader, 'pxe_loader', "hostgroup[pxe_loader]"),
          ForeignKeyAttrDefinition.new(
            :medium,
            'medium_id',
            "hostgroup[medium_id]",
            ::Puppet::Provider::ForemanMedium::ForemanMedium,
          ),
          ForeignKeyAttrDefinition.new(
            :ptable,
            'ptable_id',
            "hostgroup[ptable_id]",
            ::Puppet::Provider::ForemanPtable::ForemanPtable,
          ),
          ForeignKeyAttrDefinition.new(
            :subnet,
            'subnet_id',
            "hostgroup[subnet_id]",
            ::Puppet::Provider::ForemanSubnet::ForemanSubnet,
          ),
          ForeignKeyAttrDefinition.new(
            :subnet6,
            'subnet6_id',
            "hostgroup[subnet6_id]",
            ::Puppet::Provider::ForemanSubnet::ForemanSubnet,
          ),
          ForeignKeyAttrDefinition.new(
            :domain,
            'domain_id',
            "hostgroup[domain_id]",
            ::Puppet::Provider::ForemanDomain::ForemanDomain,
          ),
          ForeignKeyAttrDefinition.new(
            :realm,
            'realm_id',
            "hostgroup[realm_id]",
            ::Puppet::Provider::ForemanRealm::ForemanRealm,
          ),
          AttrDefinition.new(:group_parameters_attributes, 'group_parameters_attributes', "hostgroup[group_parameters_attributes]"),
          ForeignKeyAttrDefinition.new(
            :puppet_proxy,
            'puppet_proxy_id',
            "hostgroup[puppet_proxy_id]",
            ::Puppet::Provider::ForemanSmartProxy::ForemanSmartProxy,
          ),
          ForeignKeyAttrDefinition.new(
            :puppet_ca_proxy,
            'puppet_ca_proxy_id',
            "hostgroup[puppet_ca_proxy_id]",
            ::Puppet::Provider::ForemanSmartProxy::ForemanSmartProxy,
          ),
          AttrDefinition.new(:root_pass, 'root_pass', "hostgroup[root_pass]"),
          ForeignKeyArrayAttrDefinition.new(
            :locations,
            'locations',
            "hostgroup[location_ids]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :organizations,
            'organizations',
            "hostgroup[organization_ids]",
            ::Puppet::Provider::ForemanOrganization::ForemanOrganization,
            detailed: true,
          ),
        ],
      )
      @endpoint
    end
  end
end

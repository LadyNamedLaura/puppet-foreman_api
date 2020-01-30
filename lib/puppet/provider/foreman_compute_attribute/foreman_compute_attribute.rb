require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_compute_profile/foreman_compute_profile'
require 'puppet/provider/foreman_compute_resource/foreman_compute_resource'

module ::Puppet::Provider::ForemanComputeAttribute
  class ForemanComputeAttribute < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/compute_attributes',
        detailurl: '/api/compute_attributes/:id',
        composite_namevar: [:compute_resource, :compute_profile],
        attributes: [
          AttrDefinition.new(:id, 'id', nil),
          ForeignKeyAttrDefinition.new(
            :compute_profile,
            'compute_profile_id',
            "compute_profile_id",
            ::Puppet::Provider::ForemanComputeProfile::ForemanComputeProfile,
          ),
          ForeignKeyAttrDefinition.new(
            :compute_resource,
            'compute_resource_id',
            "compute_resource_id",
            ::Puppet::Provider::ForemanComputeResource::ForemanComputeResource,
          ),
          AttrDefinition.new(:vm_attrs, 'vm_attrs', "compute_attribute[vm_attrs]"),
        ],
      )
      @endpoint
    end
  end
end

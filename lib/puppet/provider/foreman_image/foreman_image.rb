require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_compute_resource/foreman_compute_resource'
require 'puppet/provider/foreman_architecture/foreman_architecture'
require 'puppet/provider/foreman_operatingsystem/foreman_operatingsystem'

module ::Puppet::Provider::ForemanImage
  class ForemanImage < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/compute_resources/:compute_resource_id/images',
        detailurl: '/api/compute_resources/:compute_resource_id/images/:id',
        composite_namevar: [:compute_resource, :name],
        attributes: [
          AttrDefinition.new(:id, 'id', nil),
          ForeignKeyAttrDefinition.new(
            :compute_resource,
            'compute_resource_id',
            "image[compute_resource_id]",
            ::Puppet::Provider::ForemanComputeResource::ForemanComputeResource,
          ),
          AttrDefinition.new(:name, 'name', "image[name]"),
          AttrDefinition.new(:username, 'username', "image[username]"),
          AttrDefinition.new(:uuid, 'uuid', "image[uuid]"),
          AttrDefinition.new(:password, 'password', "image[password]"),
          ForeignKeyAttrDefinition.new(
            :architecture,
            'architecture_id',
            "image[architecture_id]",
            ::Puppet::Provider::ForemanArchitecture::ForemanArchitecture,
          ),
          ForeignKeyAttrDefinition.new(
            :operatingsystem,
            'operatingsystem_id',
            "image[operatingsystem_id]",
            ::Puppet::Provider::ForemanOperatingsystem::ForemanOperatingsystem,
          ),
          AttrDefinition.new(:user_data, 'user_data', "image[user_data]"),
        ],
      )
      @endpoint
    end
  end
end

require 'puppet_x/foreman_api'

module ::Puppet::Provider::ForemanComputeProfile
  class ForemanComputeProfile < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/compute_profiles',
        detailurl: '/api/compute_profiles/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', nil),
          AttrDefinition.new(:name, 'name', "compute_profile[name]"),
        ],
      )
      @endpoint
    end
  end
end

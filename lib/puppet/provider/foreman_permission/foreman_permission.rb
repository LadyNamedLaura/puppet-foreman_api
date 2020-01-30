require 'puppet_x/foreman_api'

module ::Puppet::Provider::ForemanPermission
  class ForemanPermission < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/permissions',
        attributes: [
          AttrDefinition.new(:id, 'id', nil),
          AttrDefinition.new(:name, 'name', nil),
          AttrDefinition.new(:resource_type, 'resource_type', nil),
        ],
      )
      @endpoint
    end
  end
end

require 'puppet_x/foreman_api'

module ::Puppet::Provider::ForemanPermission
  class ForemanPermission < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/permissions',
        detailurl: '/api/permissions/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', nil),
        ],
      )
      @endpoint
    end
  end
end

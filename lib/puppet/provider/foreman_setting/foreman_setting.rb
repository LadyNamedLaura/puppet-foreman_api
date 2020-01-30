require 'puppet_x/foreman_api'

module ::Puppet::Provider::ForemanSetting
  class ForemanSetting < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/settings',
        detailurl: '/api/settings/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', nil),
          AttrDefinition.new(:value, 'value', "setting[value]"),
        ],
      )
      @endpoint
    end
  end
end

require 'puppet_x/foreman_api'

module ::Puppet::Provider::ForemanTemplateKind
  class ForemanTemplateKind < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/template_kinds',
        attributes: [
          AttrDefinition.new(:id, 'id', nil),
          AttrDefinition.new(:updated_at, 'updated_at', nil),
          AttrDefinition.new(:created_at, 'created_at', nil),
          AttrDefinition.new(:name, 'name', nil),
        ],
      )
      @endpoint
    end
  end
end

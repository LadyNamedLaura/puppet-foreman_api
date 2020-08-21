require 'puppet_x/foreman_api'

module ::Puppet::Provider::ForemanTemplateKind
  class ForemanTemplateKind < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/template_kinds',
        detailurl: '',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', nil),
        ],
      )
      @endpoint
    end
  end
end

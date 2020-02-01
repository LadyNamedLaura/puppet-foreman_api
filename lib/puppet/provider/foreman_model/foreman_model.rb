require 'puppet_x/foreman_api'

module ::Puppet::Provider::ForemanModel
  class ForemanModel < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/models',
        detailurl: '/api/models/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', "model[name]"),
          AttrDefinition.new(:info, 'info', "model[info]"),
          AttrDefinition.new(:vendor_class, 'vendor_class', "model[vendor_class]"),
          AttrDefinition.new(:hardware_model, 'hardware_model', "model[hardware_model]"),
        ],
      )
      @endpoint
    end
  end
end

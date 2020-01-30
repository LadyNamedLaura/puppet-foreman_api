require 'puppet_x/foreman_api'

module ::Puppet::Provider::ForemanCommonParameter
  class ForemanCommonParameter < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/common_parameters',
        detailurl: '/api/common_parameters/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', nil),
          AttrDefinition.new(:name, 'name', "common_parameter[name]"),
          AttrDefinition.new(:value, 'value', "common_parameter[value]"),
          AttrDefinition.new(:parameter_type, 'parameter_type', "common_parameter[parameter_type]"),
          AttrDefinition.new(:hidden_value, 'hidden_value', "common_parameter[hidden_value]"),
        ],
      )
      @endpoint
    end
  end
end

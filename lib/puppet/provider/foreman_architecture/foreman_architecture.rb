require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_operatingsystem/foreman_operatingsystem'

module ::Puppet::Provider::ForemanArchitecture
  class ForemanArchitecture < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/architectures',
        detailurl: '/api/architectures/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', nil),
          AttrDefinition.new(:name, 'name', "architecture[name]"),
          ForeignKeyArrayAttrDefinition.new(
            :operatingsystems,
            'operatingsystems',
            "architecture[operatingsystem_ids]",
            ::Puppet::Provider::ForemanOperatingsystem::ForemanOperatingsystem,
            detailed: true,
          ),
        ],
      )
      @endpoint
    end
  end
end

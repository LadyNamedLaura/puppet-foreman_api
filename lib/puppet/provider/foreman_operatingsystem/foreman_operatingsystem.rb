require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_architecture/foreman_architecture'
require 'puppet/provider/foreman_provisioning_template/foreman_provisioning_template'
require 'puppet/provider/foreman_medium/foreman_medium'
require 'puppet/provider/foreman_ptable/foreman_ptable'

module ::Puppet::Provider::ForemanOperatingsystem
  class ForemanOperatingsystem < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/operatingsystems',
        detailurl: '/api/operatingsystems/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', "operatingsystem[name]"),
          AttrDefinition.new(:major, 'major', "operatingsystem[major]"),
          AttrDefinition.new(:minor, 'minor', "operatingsystem[minor]"),
          AttrDefinition.new(:description, 'description', "operatingsystem[description]"),
          AttrDefinition.new(:family, 'family', "operatingsystem[family]"),
          AttrDefinition.new(:release_name, 'release_name', "operatingsystem[release_name]"),
          AttrDefinition.new(:os_parameters_attributes, 'os_parameters_attributes', "operatingsystem[os_parameters_attributes]"),
          AttrDefinition.new(:password_hash, 'password_hash', "operatingsystem[password_hash]"),
          ForeignKeyArrayAttrDefinition.new(
            :architectures,
            'architectures',
            "operatingsystem[architecture_ids]",
            ::Puppet::Provider::ForemanArchitecture::ForemanArchitecture,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :provisioning_templates,
            'provisioning_templates',
            "operatingsystem[provisioning_template_ids]",
            ::Puppet::Provider::ForemanProvisioningTemplate::ForemanProvisioningTemplate,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :media,
            'media',
            "operatingsystem[medium_ids]",
            ::Puppet::Provider::ForemanMedium::ForemanMedium,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :ptables,
            'ptables',
            "operatingsystem[ptable_ids]",
            ::Puppet::Provider::ForemanPtable::ForemanPtable,
            detailed: true,
          ),
        ],
      )
      @endpoint
    end
  end
end

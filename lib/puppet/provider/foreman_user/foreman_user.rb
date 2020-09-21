require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_location/foreman_location'
require 'puppet/provider/foreman_organization/foreman_organization'
require 'puppet/provider/foreman_role/foreman_role'
require 'puppet/provider/foreman_location/foreman_location'
require 'puppet/provider/foreman_organization/foreman_organization'

module ::Puppet::Provider::ForemanUser
  class ForemanUser < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/users',
        detailurl: '/api/users/:id',
        composite_namevar: [:login],
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:login, 'login', "user[login]"),
          AttrDefinition.new(:firstname, 'firstname', "user[firstname]"),
          AttrDefinition.new(:lastname, 'lastname', "user[lastname]"),
          AttrDefinition.new(:mail, 'mail', "user[mail]"),
          AttrDefinition.new(:description, 'description', "user[description]"),
          AttrDefinition.new(:admin, 'admin', "user[admin]"),
          AttrDefinition.new(:password, 'password', "user[password]"),
          ForeignKeyAttrDefinition.new(
            :default_location,
            'default_location_id',
            "user[default_location_id]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
          ),
          ForeignKeyAttrDefinition.new(
            :default_organization,
            'default_organization_id',
            "user[default_organization_id]",
            ::Puppet::Provider::ForemanOrganization::ForemanOrganization,
          ),
          AttrDefinition.new(:timezone, 'timezone', "user[timezone]"),
          AttrDefinition.new(:locale, 'locale', "user[locale]"),
          ForeignKeyArrayAttrDefinition.new(
            :roles,
            'roles',
            "user[role_ids]",
            ::Puppet::Provider::ForemanRole::ForemanRole,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :locations,
            'locations',
            "user[location_ids]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
            detailed: true,
            wildcardparent: :parent,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :organizations,
            'organizations',
            "user[organization_ids]",
            ::Puppet::Provider::ForemanOrganization::ForemanOrganization,
            detailed: true,
            wildcardparent: :parent,
          ),
        ],
      )
      @endpoint
    end
  end
end

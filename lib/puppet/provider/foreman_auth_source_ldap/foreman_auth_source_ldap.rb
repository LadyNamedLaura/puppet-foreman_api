require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_location/foreman_location'
require 'puppet/provider/foreman_organization/foreman_organization'

module ::Puppet::Provider::ForemanAuthSourceLdap
  class ForemanAuthSourceLdap < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/auth_source_ldaps',
        detailurl: '/api/auth_source_ldaps/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', "auth_source_ldap[name]"),
          AttrDefinition.new(:host, 'host', "auth_source_ldap[host]"),
          AttrDefinition.new(:port, 'port', "auth_source_ldap[port]"),
          AttrDefinition.new(:account, 'account', "auth_source_ldap[account]"),
          AttrDefinition.new(:base_dn, 'base_dn', "auth_source_ldap[base_dn]"),
          AttrDefinition.new(:account_password, 'account_password', "auth_source_ldap[account_password]"),
          AttrDefinition.new(:attr_login, 'attr_login', "auth_source_ldap[attr_login]"),
          AttrDefinition.new(:attr_firstname, 'attr_firstname', "auth_source_ldap[attr_firstname]"),
          AttrDefinition.new(:attr_lastname, 'attr_lastname', "auth_source_ldap[attr_lastname]"),
          AttrDefinition.new(:attr_mail, 'attr_mail', "auth_source_ldap[attr_mail]"),
          AttrDefinition.new(:attr_photo, 'attr_photo', "auth_source_ldap[attr_photo]"),
          AttrDefinition.new(:onthefly_register, 'onthefly_register', "auth_source_ldap[onthefly_register]"),
          AttrDefinition.new(:usergroup_sync, 'usergroup_sync', "auth_source_ldap[usergroup_sync]"),
          AttrDefinition.new(:tls, 'tls', "auth_source_ldap[tls]"),
          AttrDefinition.new(:groups_base, 'groups_base', "auth_source_ldap[groups_base]"),
          AttrDefinition.new(:use_netgroups, 'use_netgroups', "auth_source_ldap[use_netgroups]"),
          AttrDefinition.new(:server_type, 'server_type', "auth_source_ldap[server_type]"),
          AttrDefinition.new(:ldap_filter, 'ldap_filter', "auth_source_ldap[ldap_filter]"),
          ForeignKeyArrayAttrDefinition.new(
            :locations,
            'locations',
            "auth_source_ldap[location_ids]",
            ::Puppet::Provider::ForemanLocation::ForemanLocation,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :organizations,
            'organizations',
            "auth_source_ldap[organization_ids]",
            ::Puppet::Provider::ForemanOrganization::ForemanOrganization,
            detailed: true,
          ),
        ],
      )
      @endpoint
    end
  end
end

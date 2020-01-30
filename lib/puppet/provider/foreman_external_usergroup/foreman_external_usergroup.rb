require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_usergroup/foreman_usergroup'
require 'puppet/provider/foreman_auth_source_ldap/foreman_auth_source_ldap'

module ::Puppet::Provider::ForemanExternalUsergroup
  class ForemanExternalUsergroup < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/usergroups/:usergroup_id/external_usergroups',
        detailurl: '/api/usergroups/:usergroup_id/external_usergroups/:id',
        composite_namevar: [:usergroup, :name],
        attributes: [
          AttrDefinition.new(:id, 'id', nil),
          ForeignKeyAttrDefinition.new(
            :usergroup,
            'usergroup_id',
            "usergroup_id",
            ::Puppet::Provider::ForemanUsergroup::ForemanUsergroup,
          ),
          AttrDefinition.new(:name, 'name', "external_usergroup[name]"),
          ForeignKeyAttrDefinition.new(
            :auth_source,
            'auth_source_ldap',
            "external_usergroup[auth_source_id]",
            ::Puppet::Provider::ForemanAuthSourceLdap::ForemanAuthSourceLdap,
          ),
        ],
      )
      @endpoint
    end
  end
end

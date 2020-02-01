require 'puppet_x/foreman_api'
require 'puppet/provider/foreman_user/foreman_user'
require 'puppet/provider/foreman_usergroup/foreman_usergroup'
require 'puppet/provider/foreman_role/foreman_role'

module ::Puppet::Provider::ForemanUsergroup
  class ForemanUsergroup < ::PuppetX::ForemanApi::EndpointProvider
    include PuppetX::ForemanApi
    def self.endpoint
      @endpoint ||= Endpoint.new(
        url: '/api/usergroups',
        detailurl: '/api/usergroups/:id',
        attributes: [
          AttrDefinition.new(:id, 'id', "id"),
          AttrDefinition.new(:name, 'name', "usergroup[name]"),
          AttrDefinition.new(:admin, 'admin', "usergroup[admin]"),
          ForeignKeyArrayAttrDefinition.new(
            :users,
            'users',
            "usergroup[user_ids]",
            ::Puppet::Provider::ForemanUser::ForemanUser,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :usergroups,
            'usergroups',
            "usergroup[usergroup_ids]",
            ::Puppet::Provider::ForemanUsergroup::ForemanUsergroup,
            detailed: true,
          ),
          ForeignKeyArrayAttrDefinition.new(
            :roles,
            'roles',
            "usergroup[role_ids]",
            ::Puppet::Provider::ForemanRole::ForemanRole,
            detailed: true,
          ),
        ],
      )
      @endpoint
    end
  end
end

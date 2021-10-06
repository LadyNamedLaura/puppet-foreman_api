# @example Provide a configuration
#   class { 'foreman_api':
#     config => {
#       'base_url' => $foreman::foreman_url,
#       'ssl_ca'   => $foreman::server_ssl_ca,
#     },
#   }
# @param config
#   If set, this hash is written to /etc/foreman/foreman_api.yaml and will be used to configure the provider
class foreman_api(
  Hash[String,Hash] $resources = {},
  Boolean           $manage_agent_gems = true,
  Optional[Hash]    $config = undef,
) {
  if $manage_agent_gems {
    ensure_resource('package', 'oauth', { 'ensure' => 'installed', 'provider' => 'puppet_gem'})
  }
  $resources.each |$type, $instances| {
    $instances.each |$name, $resource| {
      ensure_resource("foreman_${type}", $name, $resource)
    }
  }

  if $config {
    file { '/etc/foreman/foreman_api.yaml':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => $config.to_yaml,
    }
  } else {
    file { '/etc/foreman/foreman_api.yaml':
      ensure  => absent,
    }
  }
}

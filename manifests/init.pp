class foreman_api(
  Hash[String,Hash] $resources = {},
  Boolean           $manage_agent_gems = true,
) {
  if $manage_agent_gems {
    ensure_resource('package', 'oauth', { 'ensure' => 'installed', 'provider' => 'puppet_gem'})
  }
  $resources.each |$type, $instances| {
    $instances.each |$name, $resource| {
      ensure_resource("foreman_${type}", $name, $resource)
    }
  }
}

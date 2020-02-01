class foreman_api(
  Hash[String,Hash] $resources = {},
) {
  $resources.each |$type, $instances| {
    $instances.each |$name, $resource| {
      ensure_resource("foreman_${type}", $name, $resource)
    }
  }
}

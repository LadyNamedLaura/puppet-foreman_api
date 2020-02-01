class foreman_api(
  Hash[String,Hash] $resources = {},
) {
  $resources.each |$type, $instances| {
    $instances.each |$name, $resource| {
      "foreman_${type}" { $name:
        * => $resource,
      }
    }
  }
}

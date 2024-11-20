## Bootstrap script
# This script performs any necessary setup before the builder.nu script is run.
use std
use std log

let attrs = (open $env.NIX_ATTRS_JSON_FILE)

log info $"Preparing Path: ($attrs.__nu_packages)"
if ($attrs.__nu_packages | is-not-empty) {
    std path add ($attrs.__nu_packages | each {|pkg| $"($pkg)/bin" })
}
std path add ($attrs.__nu_nushell | parse "{root}/nu" | get root.0) # Set the PATH so that Nushell itself is discoverable.

log info $"Preparing Libraries: ($attrs.__nu_libraries)"
# $env.NU_LIB_DIRS = $attrs.__nu_libraries | each {|lib| $"($lib)/lib" }
$env.NU_LIB_DIRS = $attrs.__nu_libraries

log info $"Preparing Outputs: ($attrs.outputs)"
$attrs.outputs | load-env

log info $"Preparing User-Supplied Env Vars: ($attrs.__nu_env)"
$env.NUENV = $attrs.__nu_env | to nuon

log info $"Loading Plugins: ($attrs.__nu_plugins)"
let plugins = $attrs.__nu_plugins | each {|plugin| ls $"($plugin)/bin" | get name.0 }
$plugins | each {|p| plugin add --plugin-config $attrs.__nu_plugin_config $p}

# Run the Nushell builder
(nu
    --log-level warn
    --config $attrs.__nu_config
    --env-config $attrs.__nu_env_config
    --plugin-config $attrs.__nu_plugin_config
    --plugins ($plugins | to nuon)
    $attrs.__nu_builder
)
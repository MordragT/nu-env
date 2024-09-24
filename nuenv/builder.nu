## Builder script
# This script performs the building of the derivation.

use std
use std log

log info $"Attr Json File: ($env.NIX_ATTRS_JSON_FILE)"

let attrs = (open $env.NIX_ATTRS_JSON_FILE)

std path add (
    $attrs.__nu_packages
    | each {|pkg| $"($pkg)/bin" }
)

log info $"PATH: ($env.PATH)"

log info $"Extra Attrs: ($attrs.__nu_extra_attrs)"

$attrs.__nu_extra_attrs | load-env

log info $"Outputs: ($attrs.outputs)"

$attrs.outputs | load-env

log info $"Plugins: ($attrs.__nu_plugins)"

let plugins = $attrs.__nu_plugins | str join " "

nu --log-level warn --env-config $attrs.__nu_env_config --plugins $'[($plugins)]' --commands $attrs.__nu_build
# nu --log-level warn --env-config $attrs.__nu_env_config --commands $attrs.__nu_build
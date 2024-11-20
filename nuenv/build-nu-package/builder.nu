use std log

log info $"Creating `bin` and `lib` path in ($env.out)"
mkdir $env.out
mkdir ($env.out | path join "bin")
mkdir ($env.out | path join "lib")

let shell = (which nu).path.0

let lib_dir = [$env.out "lib" "nu"] | path join
log info $"Copying source to packages library dir: ($lib_dir)"
cp -r $env.src $lib_dir

log info "Construct plugin config"
let plugin_config = $lib_dir | path join "plugin.msgpackz"
$env.plugins | each {|p| plugin add --plugin-config $plugin_config $p}

log info "Construct env config"
let env_config = [$env.out "bin" ".env-config"] | path join
$"
    use std

    let packages = '($env.packages | to nuon)' | from nuon
    if \($packages | is-not-empty) {
        std path add \($packages | each {|pkg| $pkg | path join 'bin' })
    }

    $env.NU_LIB_DIRS = \('($env.dependencies | to nuon)' | from nuon) | append '($lib_dir)'

    let environment = '($env.env | to nuon)' | from nuon
    load-env $environment
" | save $env_config

for script in ($env.scripts | transpose name source) {
    log info $"Setting up ($script.name) script"

    let target = [$env.out "bin" $script.name] | path join

    $"#! /usr/bin/env -S ($shell) --env-config ($env_config) --plugin-config ($plugin_config) --plugins ($env.plugins | to nuon)
    source ($lib_dir | path join $script.source)
    " | save $target

    ^chmod a+x $target
}
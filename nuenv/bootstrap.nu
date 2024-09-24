## Bootstrap script
# This script performs any necessary setup before the builder.nu script is run.

let attrs = (open $env.NIX_ATTRS_JSON_FILE)

# Set the PATH so that Nushell itself is discoverable.
$env.PATH = ($attrs.__nu_nushell | parse "{root}/nu" | get root.0)

# Run the Nushell builder
nu --commands (open $attrs.__nu_builder)
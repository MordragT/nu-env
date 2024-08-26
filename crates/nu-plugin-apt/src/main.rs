use nu_plugin::{serve_plugin, MsgPackSerializer};
use nu_plugin_apt::AptCmdsPlugin;

fn main() {
    serve_plugin(&AptCmdsPlugin, MsgPackSerializer {})
}

use nu_plugin::{Plugin, PluginCommand};

pub mod from;

use from::packages::FromAptPackages;

pub struct AptCmdsPlugin;

impl Plugin for AptCmdsPlugin {
    fn version(&self) -> String {
        env!("CARGO_PKG_VERSION").into()
    }

    fn commands(&self) -> Vec<Box<dyn PluginCommand<Plugin = Self>>> {
        vec![Box::new(FromAptPackages)]
    }
}

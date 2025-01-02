use apt_parser as apt;
use nu_plugin::{EngineInterface, EvaluatedCall, SimplePluginCommand};
use nu_protocol::{record, Category, LabeledError, Signature, Span, Type, Value};

use crate::AptCmdsPlugin;

pub struct FromAptPackages;

impl SimplePluginCommand for FromAptPackages {
    type Plugin = AptCmdsPlugin;

    fn name(&self) -> &str {
        "from apt-packages"
    }

    fn signature(&self) -> Signature {
        Signature::build(self.name())
            .input_output_types(vec![(Type::String, Type::table())])
            .category(Category::Formats)
    }

    fn description(&self) -> &str {
        "Parse Apt Packages files and create a table."
    }

    fn run(
        &self,
        _plugin: &Self::Plugin,
        _engine: &EngineInterface,
        call: &EvaluatedCall,
        input: &Value,
    ) -> Result<Value, LabeledError> {
        let span = input.span();
        let input_str = input.coerce_str()?;
        let head = call.head;

        let packages = apt::Packages::from(&input_str);

        if !packages.errors.is_empty() {
            todo!()
        }

        let mut table = Vec::new();

        for package in packages {
            let apt::Package {
                package,
                source,
                version,
                section,
                priority,
                architecture,
                is_essential,
                depends,
                pre_depends,
                recommends,
                suggests,
                replaces,
                enhances,
                breaks,
                conflicts,
                installed_size,
                maintainer,
                description,
                homepage,
                built_using,
                package_type,
                tags,
                filename,
                size,
                md5sum,
                sha1sum,
                sha256sum,
                sha512sum,
                description_md5sum,
                ..
            } = package;

            let row = record! {
                "package" => Value::string(package, head),
                "source" => source.map_or(Value::nothing(head), |s| Value::string(s, head)),
                "version" =>  Value::string(version, head),
                "section" => section.map_or(Value::nothing(head), |s| Value::string(s, head)),
                "priority" => priority.map_or(Value::nothing(head), |s| Value::string(s, head)),
                "architecture" => Value::string(architecture, head),
                "is_essential" => is_essential.map_or(Value::nothing(head), |b| Value::bool(b, head)),
                "depends" => depends.map_or(Value::nothing(head), |l| to_list(l, head)),
                "pre_depends" => pre_depends.map_or(Value::nothing(head), |l| to_list(l, head)),
                // TODO
                "filename" => Value::string(filename, head),
                "size" => Value::int(size, head),
                "md5" => md5sum.map_or(Value::nothing(head), |s| Value::string(s, head)),
                "sha1" => sha1sum.map_or(Value::nothing(head), |s| Value::string(s, head)),
                "sha256" => sha256sum.map_or(Value::nothing(head), |s| Value::string(s, head)),
                "sha512" => sha512sum.map_or(Value::nothing(head), |s| Value::string(s, head)),
            };

            table.push(Value::record(row, span));
        }

        Ok(Value::list(table, head))
    }
}

fn to_list(input: Vec<String>, span: Span) -> Value {
    let list = input.into_iter().map(|s| Value::string(s, span)).collect();
    Value::list(list, span)
}

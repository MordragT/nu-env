use std log

export def main [source: path, target: path, --args = [], --vars = {}] {
    # TODO check if is executable (permissions not implemented in nushell yet)
    if ($source | path exists) {
        return (error make {
            msg: $"Source does not exist",
            label: {
                text: "This argument",
                span: (metadata $source).span
            }
        })
    }

    mkdir ($target | path dirname)

    let shell = (which nu).path.0

    $"#! ($shell)

    def main [...args] {
        let arguments = '($args | to nuon)' | from nuon
        let environment = '($vars | to nuon)' | from nuon

        with-env $environment {
            run-external '($source)' ...$arguments ...$args
        }
    }
    " | save $target

    ^chmod +x $target 
}

export def inplace [exe: path, --args = [], --vars = {}] {
    let source = $"($exe | path dirname)/.($exe | path basename)-(random chars)"
    mv $exe $source
    main $source $exe --args $args --vars $vars
}

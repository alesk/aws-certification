function BlastRadius {
  docker run --cap-add=SYS_ADMIN -it --rm -p 5000:5000 -v $env:HOME/.aws:/root/.aws -v ${pwd}:/workdir:ro 28mm/blast-radius
}

set-alias br BlastRadius

function BuildImage {
    docker build --no-cache -t utils -f Dockerfile-utils .
}

set-alias build BuildImage

function ui() {
    if (test-path ${PWD}/../modules) {
        $modules = "-v ${PWD}/../modules:/workdir/modules"
    } else {
        $modules = ""
    }

    $command = @"
  docker run --rm -it ``
    -v $Env:HOME/.aws:/root/.aws ``
    -v $Env:HOME/.ssh:/root/.ssh ``
    -v $Env:HOME/.kube:/root/.kube ``
    -v ${PWD}:/workdir/env ``
    $modules ``
    -w /workdir/env ``
    utils $args
"@
    iex $command
}
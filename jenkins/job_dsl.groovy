folder('Whanos_base_images') {
    displayName('Whanos base images')
    description('Folder for Whanos base images')
}

folder('Projects') {
    displayName('Projects')
    description('Folder for projects')
}

freeStyleJob('Whanos_base_images/whanos-c') {
    steps {
        shell('docker build -t whanos-c -f /whanos/images/c/Dockerfile.base .')
    }
}

freeStyleJob('Whanos_base_images/whanos-java') {
    steps {
        shell('docker build -t whanos-java -f /whanos/images/java/Dockerfile.base .')
    }
}

freeStyleJob('Whanos_base_images/whanos-javascript') {
    steps {
        shell('docker build -t whanos-javascript -f /whanos/images/javascript/Dockerfile.base .')
    }
}

freeStyleJob('Whanos_base_images/whanos-python') {
    steps {
        shell('docker build -t whanos-python -f /whanos/images/python/Dockerfile.base .')
    }
}

freeStyleJob('Whanos_base_images/whanos-befunge') {
    steps {
        shell('cd /whanos/images/befunge/app ; docker build -t whanos-befunge-internal -f /whanos/images/befunge/Dockerfile.internal .')
        shell('docker build -t whanos-befunge -f /whanos/images/befunge/Dockerfile.base .')
    }
}

freeStyleJob('Whanos_base_images/Build all base images') {
    keepDependencies(false)
    concurrentBuild(true)
    publishers {
        downstream("whanos-c, whanos-java, whanos-python, whanos-javascript, whanos-befunge", "SUCCESS")
    }
}

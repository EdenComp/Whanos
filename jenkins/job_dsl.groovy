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
        shell('docker build -t image-c -f Dockerfile.base .')
    }
}

freeStyleJob('Whanos_base_images/whanos-java') {
    steps {
        shell('docker build -t image-java -f Dockerfile.base .')
    }
}

freeStyleJob('Whanos_base_images/whanos-javascript') {
    steps {
        shell('docker build -t image-javascript -f Dockerfile.base .')
    }
}

freeStyleJob('Whanos_base_images/whanos-python') {
    steps {
        shell('docker build -t image-python -f Dockerfile.base .')
    }
}

freeStyleJob('Whanos_base_images/whanos-befunge') {
    steps {
        shell('docker build -t image-befunge -f Dockerfile.base .')
    }
}

freeStyleJob('Whanos_base_images/Build all base images') {
    keepDependencies(false)
    concurrentBuild(true)
    publishers {
        downstream("whanos-c, whanos-java, whanos-python, whanos-javascript, whanos-befunge", "SUCCESS")
    }
}

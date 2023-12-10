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
    keepDependencies(true)
    concurrentBuild(true)
    publishers {
        downstream("whanos-c, whanos-java, whanos-python, whanos-javascript, whanos-befunge", "SUCCESS")
    }
}

freeStyleJob("Projects/Link Project") {
    parameters {
        stringParam("PROJECT_REPO", null, "Project repository (HTTPS)")
        stringParam("PROJECT_NAME", null, "Project display name")
        stringParam("IMAGE_NAME", null, "Name of the docker image (kebab-case)")
        stringParam("BRANCH", "main", "Branch")
        textParam("SSH_PRIVATE_KEY", null, "SSH private key (for private repositories)")
    }
    steps {
        dsl {
            text('''freeStyleJob("Projects/\$PROJECT_NAME") {
                triggers {
                    scm("* * * * *")
                }
                scm {
                    git {
                        remote {
                            url("\$PROJECT_REPO")
                        }
                        branch("\$BRANCH")
                    }
                }
                steps {
                    shell("/whanos/scripts/repository_deploy.sh `pwd` \$IMAGE_NAME")
                }
                wrappers {
                    preBuildCleanup {
                        deleteDirectories(false)
                        cleanupParameter()
                    }
                }
            }''')
        }
    }
}

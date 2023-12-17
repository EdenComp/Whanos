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

freeStyleJob('Whanos_base_images/whanos-rust') {
    steps {
        shell('docker build -t whanos-rust -f /whanos/images/rust/Dockerfile.base .')
    }
}

freeStyleJob('Whanos_base_images/Build all base images') {
    keepDependencies(true)
    concurrentBuild(true)
    publishers {
        downstream("whanos-c, whanos-java, whanos-python, whanos-javascript, whanos-befunge, whanos-rust", "SUCCESS")
    }
}

freeStyleJob("Projects/Link Project") {
    parameters {
        stringParam("PROJECT_REPO", null, "Project repository (HTTPS for public or SSH for private)")
        stringParam("PROJECT_NAME", null, "Project display name")
        stringParam("IMAGE_NAME", null, "Name of the docker image (kebab-case)")
        stringParam("BRANCH", "main", "Branch")
        credentialsParam('SSH_PRIVATE_KEY') {
            type('com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey')
            description('SSH private key (for private repositories)')
        }
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
                            credentials("$SSH_PRIVATE_KEY")
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

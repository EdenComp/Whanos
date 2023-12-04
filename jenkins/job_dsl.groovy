// folder('Whanos_base_images42') {
//   displayName('Whanos base images')
//   description('Folder for Whanos base images')
// }

// freeStyleJob('Whanos_base_images/whanos-c') {
//   wrappers {
//     preBuildCleanup ()
//   }
//   parameters {
//     stringParam("GIT_REPOSITORY_URL", "", "Git URL of the repository to clone")
//   }
//   scm {
//     git {
//       remote {
//         url('\$GIT_REPOSITORY_URL')
//       }
//     }
//   }
// }

freeStyleJob('Whanos_base_images/whanos-java') {
  wrappers {
    preBuildCleanup ()
  }
  parameters {
    stringParam("GIT_REPOSITORY_URL", "", "Git URL of the repository to clone")
  }
  scm {
    git {
      remote {
        url('\$GIT_REPOSITORY_URL')
      }
    }
  }
}

freeStyleJob('Whanos_base_images/whanos-javascript') {
  wrappers {
    preBuildCleanup ()
  }
  parameters {
    stringParam("GIT_REPOSITORY_URL", "", "Git URL of the repository to clone")
  }
  scm {
    git {
      remote {
        url('\$GIT_REPOSITORY_URL')
      }
    }
  }
}

freeStyleJob('Whanos_base_images/whanos-python') {
  wrappers {
    preBuildCleanup ()
  }
  parameters {
    stringParam("GIT_REPOSITORY_URL", "", "Git URL of the repository to clone")
  }
  scm {
    git {
      remote {
        url('\$GIT_REPOSITORY_URL')
      }
    }
  }
}

// freeStyleJob('Whanos_base_images/whanos-befunge') {
//   wrappers {
//     preBuildCleanup ()
//   }
//   parameters {
//     stringParam("GIT_REPOSITORY_URL", "", "Git URL of the repository to clone")
//   }
//   scm {
//     git {
//       remote {
//         url('\$GIT_REPOSITORY_URL')
//       }
//     }
//   }
// }

// folder('Projects') {
//   displayName('Projects')
//   description('Folder for projects')
// }

// folder('Whanos_base_images/Build_all_base_images') {
//   displayName('Build all base images')
//   description('Folder for build all base images')
// }

// folder ('link-project') {
//   displayName('link-project')
//   description('Folder for link-project')
// }

// pipeline {
//     agent any
//     stages {
//         stage('Test') {
//             steps {
//                 sh 'docker build -t tahaunique ../../../Desktop/delivery/tech3/devops/Whanos/jenkins'
//             }
//         }
//     }
// }


// pipeline {
//     agent any
//     stages {
//         stage('Build') {
//             steps {
//                 sh 'pwd'
//                 sh 'ls -la'
//             }
//         }
//         stage('Test') {
//             steps {
//                 sh 'make test'
//             }
//         }
//         stage('Publish') {
//             steps {
//                 sh 'make publish'
//             }
//         }
//     }
// }

freeStyleJob('Tools/SEED') {
  parameters {
    stringParam("GITHUB_NAME", "", 'GitHub repository owner/repo_name (e.g.: "EpitechIT31000/chocolatine")')
    stringParam("DISPLAY_NAME", "", "Display name for the job")
  }
  steps {
    dsl {
      text('''freeStyleJob("\$DISPLAY_NAME") {
        scm {
          github("\$GITHUB_NAME")
          triggers {
            scm('* * * * *')
          }
        }
        wrappers {
          preBuildCleanup()
        }
        steps {
          shell('make fclean')
          shell('make')
          shell('make tests_run')
          shell('make clean')
        }
      }'''.stripIndent())
    }
  }
}

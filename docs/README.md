# Whanos - La guerre des baleines

## Introduction

Whanos is a project that aims to automatize any projets using the following languages:

- C
- Python
- Javascript
- Java
- Befunge
- Rust

The automation is done by automatically fetching your repository for changes, and by automatically building and deploying your application!

> Work in progress: Automatically deploy your application on Kubernetes!

## Installation

If you wish to install Whanos on your own server, you can follow the following steps:

- Clone the repository
- Install Ansible on your local machine
- Prepare a server that will host Whanos and follow the steps [here](./ansible.md)

## How to use

Now that your own installation of Whanos is ready, you can use it to deploy your own projects!

Here is the steps to follow:

- Go to your Jenkins login page and use the credentials you set when you installed Whanos using Ansible.

> :bulb: The default username is `admin` and the default password has been asked during the installation.

- **Only once** : Launch the *Build all base images* job, that will build the intermediate images used to build your projects.
- **Only once per project (or per branch)** : Go to the Projects folder and use the **Link Project** job with the following parameters:

    - **Project name**: The name of your project
    - **Git repository**: The URL of your Git repository
    - **Git branch**: The branch of your Git repository to use (default: main)
    - **Git credentials**: The credentials to use to fetch your repository
    - **Docker image name**: The name of the Docker image to build (it must follow the Docker image naming convention)

> :warning: The Git repository URL must be a HTTPS URL if the repository is public, or a SSH URL if the repository is private. If so, you must provide the SSH key to use to fetch your repository.

And that's it ! Now everytime the selected branch is updated, the project will be automatically built and deployed!

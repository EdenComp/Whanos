# Ansible

We use Ansible to configure the servers. Here are all the steps to use Ansible :

## Part 1 : Jenkins

This is because Kubernetes needs a special configuration, named *Kubespray*.

The first inventory only needs one server, and is the server in which Jenkins will be installed.

:warning: The SSH key used to connect to the server is located in `~/.ssh/id_rsa`.
Your SSH key must be added on the server authorized keys.

All you have to do is to run the following command:

```bash
bash ./scripts/deploy_jenkins.sh
```

Please follow the steps and provide the necessary information.
After the script is finished, Jenkins will be fully installed and configured on your server.

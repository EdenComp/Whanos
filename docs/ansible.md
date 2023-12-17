# Ansible

We use Ansible to configure the servers. Here are all the steps to use Ansible and get the Whanos infrastructure deployed.

### Simple as "bonjour"

:warning: The SSH key used to connect to the server is located in `~/.ssh/id_rsa`.
Your SSH key must be added on the servers authorized keys.

All you have to do is to run the following command:

```bash
bash ./scripts/ansible/deploy_whanos.sh <master_ip> <kubernetes_ips>
```

> :warning: You need at least 2 IPs, one for the master (the machine on which Jenkins will be installed) and as many as you want for the Kubernetes cluster.

Please follow the steps and provide the necessary information.

> :bulb: Right after the script launch, you should land into a file, in which you can see your different Kubernetes nodes in a YAML syntax. \
> All you have to do is replace the `ip` and `access_ip` fields with the **private IP** of each machine.

After the script is finished, Jenkins will be fully installed and configured on your server.

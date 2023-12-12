GIT_ROOT_PATH=$(git rev-parse --show-toplevel)
VAULT=$GIT_ROOT_PATH/ansible/group_vars/all.yml

read -s -p "Enter the Jenkins admin password: " jenkins_password
echo ""
read -s -p "Enter the Docker registry domain: " docker_registry
echo ""
read -s -p "Enter the Docker registry user: " docker_registry_user
echo ""
read -s -p "Enter the Docker registry password: " docker_registry_password
echo ""

read -s -p "Enter the Ansible Vault password: " vault_password
echo ""

rm -f $VAULT
touch $VAULT
echo "jenkins_admin_password: \"$jenkins_password\"" >> $VAULT
echo "docker_registry: \"$docker_registry\"" >> $VAULT
echo "docker_registry_user: \"$docker_registry_user\"" >> $VAULT
echo "docker_registry_password: \"$docker_registry_password\"" >> $VAULT

echo $vault_password > password
ansible-vault encrypt $VAULT --vault-password-file password
rm -f password

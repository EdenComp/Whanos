GIT_ROOT_PATH=$(git rev-parse --show-toplevel)
VAULT=$GIT_ROOT_PATH/ansible/group_vars/all.yml
INVENTORY=$GIT_ROOT_PATH/ansible/whanos-inventory

if [ -f "$INVENTORY" ]; then
    read -p "Ansible inventory already exists: regenerate? " regen_inv
    if [[ $regen_inv == [yY] || $regen_inv == [yY][eE][sS] ]]; then
      bash $GIT_ROOT_PATH/scripts/ansible/generate_inventory.sh $@
    fi
else
    echo "Ansible inventory does not exist! Generating..."
    bash $GIT_ROOT_PATH/scripts/ansible/generate_inventory.sh $@
fi

if [ -f "$VAULT" ]; then
    read -p "Ansible vault already exists: regenerate? " regen_vault
    if [[ $regen_vault == [yY] || $regen_vault == [yY][eE][sS] ]]; then
      bash $GIT_ROOT_PATH/scripts/ansible/create_vault.sh
    fi
else
    echo "Ansible vault does not exist! Creating..."
    bash $GIT_ROOT_PATH/scripts/ansible/create_vault.sh
fi

#bash $GIT_ROOT_PATH/scripts/ansible/deploy_kubernetes.sh ${@:2}
bash $GIT_ROOT_PATH/scripts/ansible/deploy_jenkins.sh

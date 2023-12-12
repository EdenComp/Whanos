GIT_ROOT_PATH=$(git rev-parse --show-toplevel)
VAULT=$GIT_ROOT_PATH/ansible/group_vars/all.yml
INVENTORY=$GIT_ROOT_PATH/ansible/whanos-inventory

if [ -f "$INVENTORY" ]; then
    read -p "Ansible inventory already exists: regenerate? " regen_inv
    if [[ $regen_inv == [yY] || $regen_inv == [yY][eE][sS] ]]; then
      bash $GIT_ROOT_PATH/scripts/ansible/create_vault.sh
    fi
else
    echo "Ansible inventory does not exists! Generating..."
fi

if [ -f "$VAULT" ]; then
    read -p "Ansible vault already exists: regenerate? " regen_vault
    if [[ $regen_vault == [yY] || $regen_vault == [yY][eE][sS] ]]; then
      bash $GIT_ROOT_PATH/scripts/ansible/create_vault.sh
    fi
else
    echo "Ansible vault does not exists! Creating..."
fi

ansible-playbook -i $INVENTORY $GIT_ROOT_PATH/ansible/playbook.yml --ask-vault-pass

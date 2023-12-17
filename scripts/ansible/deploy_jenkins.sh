GIT_ROOT_PATH=$(git rev-parse --show-toplevel)
INVENTORY=$GIT_ROOT_PATH/ansible/whanos-inventory

ansible-playbook -i $INVENTORY $GIT_ROOT_PATH/ansible/playbook.yml --ask-vault-pass

GIT_ROOT_PATH=$(git rev-parse --show-toplevel)
INVENTORY=$GIT_ROOT_PATH/ansible/whanos-inventory

read -p "Enter the server public IP: " public_ip
echo -ne "$public_ip\n\n[jenkins]\n$public_ip\n" > $INVENTORY

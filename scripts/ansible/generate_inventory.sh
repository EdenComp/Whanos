GIT_ROOT_PATH=$(git rev-parse --show-toplevel)
INVENTORY=$GIT_ROOT_PATH/ansible/whanos-inventory

if [ $# -lt 2 ]; then
    echo "Error: You need at least 2 IPs, one for Jenkins and the others for Kubernetes."
    exit 1
fi

rm -f $INVENTORY
touch $INVENTORY

for var in "$@"
do
    echo "$var" >> $INVENTORY
done

echo -ne "\n[master]\n$1\n\n[jenkins]\n$1\n" >> $INVENTORY

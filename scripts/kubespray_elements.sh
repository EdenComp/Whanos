cd /ansible/kubespray
cp -rfp inventory/sample inventory/ignite
declare -a IPS=("$@")
CONFIG_FILE=inventory/ignite/hosts.yml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
sed -i -r 's/^(dns_mode:).*/\1 none/g' inventory/ignite/group_vars/k8s_cluster/k8s-cluster.yml

# Warning: Please use this script only in the kubespray Docker container

cd /ansible/kubespray
cp -rfp inventory/sample inventory/ignite

declare -a IPS=("$@")
for ((i=0; i<${#IPS[@]}; i++)); do
    IPS[i]=${IPS[i]#*@}
done

CONFIG_FILE=inventory/ignite/hosts.yml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
sed -i -r 's/^(dns_mode:).*/\1 none/g' inventory/ignite/group_vars/k8s_cluster/k8s-cluster.yml

emacs ./inventory/ignite/hosts.yml
ansible-playbook -i inventory/ignite cluster.yml
scp $1:/etc/kubernetes/admin.conf /kubeconfig
cat /kubeconfig | sed "s/    server: https:\/\/127.0.0.1:6443/    server: https:\/\/${IPS[0]#*@}:6443/" > /app/ansible/kubeconfig

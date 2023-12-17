GIT_ROOT_PATH=$(git rev-parse --show-toplevel)
cd $GIT_ROOT_PATH/ansible
docker build -t kubespray:latest .

cd ..
docker run -it --rm -v $(pwd):/app -v ~/.ssh:/root/.ssh -w /app kubespray:latest /app/scripts/ansible/kubespray_elements.sh $@

# Arguments handling
if [ $# -eq 0 ] || [ $1 = "-h" ]; then
    echo "Usage: $0 <directory> [project name]"
    exit 1
fi

# Find if the repo is whanos-compatible
VALID_CRITERIA=0
if [ -z "$2" ]; then
    IMAGE_NAME=$(basename -s .git `git config --get remote.origin.url` | sed 's/\([^A-Z]\)\([A-Z0-9]\)/\1-\2/g' | sed 's/\([A-Z0-9]\)\([A-Z0-9]\)\([^A-Z]\)/\1-\2\3/g' | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
else
    IMAGE_NAME=$2
fi

echo $PROJECT_NAME
if [ -f "app/main.bf" ]; then
    VALID_CRITERIA=$((VALID_CRITERIA+1))
    LANGUAGE="befunge"
fi
if [ -f "Makefile" ]; then
    VALID_CRITERIA=$((VALID_CRITERIA+1))
    LANGUAGE="c"
fi
if [ -f "app/pom.xml" ]; then
    VALID_CRITERIA=$((VALID_CRITERIA+1))
    LANGUAGE="java"
fi
if [ -f "package.json" ]; then
    VALID_CRITERIA=$((VALID_CRITERIA+1))
    LANGUAGE="javascript"
fi
if [ -f "requirements.txt" ]; then
    VALID_CRITERIA=$((VALID_CRITERIA+1))
    LANGUAGE="python"
fi
if [ -f "Cargo.toml" ]; then
    VALID_CRITERIA=$((VALID_CRITERIA+1))
    LANGUAGE="rust"
fi

if [ $VALID_CRITERIA -eq 0 ]; then
    echo "This repository is not whanos-compatible"
    exit 1
fi
if [ $VALID_CRITERIA -gt 1 ]; then
    echo "This repository matches multiple whanos criteria, please remove the ambiguity"
    exit 1
fi

# Build the image
SCRIPT_DIR=$(realpath $(dirname $0))

if [ -f "Dockerfile" ]; then
  docker build . -t ghcr.io/edencomp/whanos-$IMAGE_NAME:latest
else
  docker build . --file $SCRIPT_DIR/../images/$LANGUAGE/Dockerfile.standalone -t ghcr.io/edencomp/whanos-$IMAGE_NAME:latest
fi

docker push ghcr.io/edencomp/whanos-$IMAGE_NAME:latest

if [ -f "whanos.yml" ]; then
  mkdir -p ./k8s
  cat $SCRIPT_DIR/../k8s/whanos.deployment.yml | sed "s/IMAGE/ghcr.io\/edencomp\/whanos-$IMAGE_NAME:latest/g" > ./k8s/whanos.deployment.yml
  cp $SCRIPT_DIR/../k8s/whanos.service.yml ./k8s/whanos.service.yml

  kubectl apply --insecure-skip-tls-verify -f ./k8s/whanos.deployment.yml -f ./k8s/whanos.service.yml
fi

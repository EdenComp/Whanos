# Arguments handling
if [ $# -eq 0 ] || [ $1 = "-h" ]; then
    echo "Usage: $0 <repository_url> [branch]"
    exit 1
fi

BRANCH_PARAM=""
if [ $# -eq 2 ]; then
    BRANCH_PARAM="--branch $2"
fi

mkdir -p /tmp/whanos
rm -rf /tmp/whanos/repository
git clone $1 $BRANCH_PARAM /tmp/whanos/repository && cd /tmp/whanos/repository

# Find if the repo is whanos-compatible
VALID_CRITERIA=0
REPO_NAME=$(basename -s .git `git config --get remote.origin.url`)

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

if [ $VALID_CRITERIA -eq 0 ]; then
    echo "This repository is not whanos-compatible"
    exit 1
fi
if [ $VALID_CRITERIA -gt 1 ]; then
    echo "This repository matches multple whanos criteria, please remove the ambiguity"
    exit 1
fi

# Build the image
SCRIPT_DIR=$(realpath $(dirname $0))

if [ -f "Dockerfile" ]; then
  docker build . -t $REPO_NAME:latest
else
  docker build . --file $SCRIPT_DIR/../images/$LANGUAGE/Dockerfile.standalone -t $REPO_NAME:latest
fi

# TODO: Deploy image on docker registry + k8s

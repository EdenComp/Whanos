GIT_ROOT_PATH=$(git rev-parse --show-toplevel)
IMAGES_DIR=$GIT_ROOT_PATH/images

docker build $IMAGES_DIR/c --file $IMAGES_DIR/c/Dockerfile.base -t whanos-c:latest

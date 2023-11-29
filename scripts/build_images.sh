GIT_ROOT_PATH=$(git rev-parse --show-toplevel)
IMAGES_DIR=$GIT_ROOT_PATH/images

docker build $IMAGES_DIR/befunge/app --file $IMAGES_DIR/befunge/Dockerfile.internal -t whanos-befunge-internal:latest
docker build $IMAGES_DIR/befunge --file $IMAGES_DIR/befunge/Dockerfile.base -t whanos-befunge:latest
docker build $IMAGES_DIR/c --file $IMAGES_DIR/c/Dockerfile.base -t whanos-c:latest
docker build $IMAGES_DIR/java --file $IMAGES_DIR/java/Dockerfile.base -t whanos-java:latest
docker build $IMAGES_DIR/javascript --file $IMAGES_DIR/javascript/Dockerfile.base -t whanos-javascript:latest
docker build $IMAGES_DIR/python --file $IMAGES_DIR/python/Dockerfile.base -t whanos-python:latest

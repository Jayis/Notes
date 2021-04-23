nvidia-docker run -it --rm --ipc=host \
    -v $HOST_DIR:$CONTAINER_DIR \
    -p $HOST_PORT:$CONTAINER_PORT \
    --name $CONTAINER_NAME \
    $IMAGE_REPOSITORY:$TAG \
    /bin/bash
#!/bin/bash
NAME=hshekhar47/hdfs-datanode
VERSION=0.1

BUILD_DIR=$(dirname "${BASH_SOURCE[0]}")

clean() {
    echo "Cleaning ${NAME}:${VERSION}";
    docker image rm ${NAME}:${VERSION}
    if [ "$?" == "0" ]; then
        echo "[CLEAN]: Removed Image ${NAME}:${VERSION} successfully."; 
        return 0;
    else
        return 1;
    fi 
}

build() {
    clean
    docker build -t ${NAME}:${VERSION} ${BUILD_DIR} && { echo "[BUILD]: ${NAME}:${VERSION} created successfully."; return 0;}
    return 1;
}


case "$1" in
    "clean") 
        clean;;
    *) 
        build;;
esac

exit $?;
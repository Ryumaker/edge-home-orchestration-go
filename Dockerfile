# Docker image for "edge-orchestration"
# TODO - need to reduce base image of edge-orchestration
### ubuntu:20.04 image size is 119MB
### alpine:3.6 image size is 4MB
ARG PLATFORM
FROM $PLATFORM/ubuntu:20.04

# environment variables
ENV TARGET_DIR=/edge-orchestration
ENV HTTP_PORT=56001
ENV MDNS_PORT=5353
ENV MNEDC_PORT=3334
ENV MNEDC_BROADCAST_PORT=3333
ENV ZEROCONF_PORT=42425
ENV APP_BIN_DIR=bin
ENV APP_NAME=edge-orchestration
ENV APP_QEMU_DIR=$APP_BIN_DIR/qemu
ENV BUILD_DIR=build

# copy files
COPY $APP_BIN_DIR/$APP_NAME $BUILD_DIR/package/run.sh $TARGET_DIR/
COPY $APP_QEMU_DIR/ /usr/bin/
RUN mkdir -p $TARGET_DIR/res/

# install required tools
RUN apt-get update
RUN apt-get install -y net-tools iproute2

# expose ports
EXPOSE $HTTP_PORT $MDNS_PORT $ZEROCONF_PORT $MNEDC_PORT $MNEDC_BROADCAST_PORT

# set the working directory
WORKDIR $TARGET_DIR

# kick off the edge-orchestration container
CMD ["sh", "run.sh"]

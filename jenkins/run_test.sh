#!/bin/bash -x

DESIGN=$1
PLATFORM=$2

user_id="$(id -u ${USER}):$(id -g ${USER})"
flow_mount="$(pwd)/flow:/OpenROAD-flow/flow"
docker_tag="openroad/flow"

docker_script="source setup_env.sh && \
  cd flow/flow && \
  test/test_helper.sh ${DESIGN} ${PLATFORM}; \
  status=\$?; \
  make metadata DESIGN_CONFIG=designs/${PLATFORM}/${DESIGN}/config.mk && \
  exit \$status"

# Additional DOCKER_OPTS should be set in the environment
docker run --rm -u ${user_id} -v ${flow_mount} ${DOCKER_OPTS} -e PATH -e LD_LIBRARY_PATH -e MAKE_ISSUE -e USER ${docker_tag} bash -xc "${docker_script}"

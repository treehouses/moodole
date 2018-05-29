#!/usr/bin/env bash

source ./.travis/travis_utils.sh

build_message Preparing builds...
prepare_package

build_message Build x86 image started...
deploy_x86
build_message Build x86 image finished, check build result!

build_message Build x86 Apache image started...
deploy_x86_apache
build_message Build x86 Apache image finished, check build result!

build_message Build x86 Alpine image started...
deploy_x86_alpine
build_message Build x86 Alpine image finished, check build result!

build_message Now building for ARM...
bash ./.travis/deploy_docker_rpi.sh  --branch="$BRANCH" --commit="$COMMIT" --duser="$DOCKER_USER" --dpass="$DOCKER_PASS"

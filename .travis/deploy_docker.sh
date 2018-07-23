#!/usr/bin/env bash

source ./.travis/travis_utils.sh

build_message Preparing builds...
prepare_package

build_message Build amd64 image started...
deploy_amd64
build_message Build amd64 image finished, check build result!

build_message Build amd64 Apache image started...
deploy_amd64_apache
build_message Build amd64 Apache image finished, check build result!

build_message Build amd64 Alpine image started...
deploy_amd64_alpine
build_message Build amd64 Alpine image finished, check build result!

build_message Now building for ARM,ARM64...
bash ./.travis/deploy_docker_rpi.sh  --branch="$BRANCH" --commit="$COMMIT" --duser="$DOCKER_USER" --dpass="$DOCKER_PASS"
build_message Build for ARM,ARM64 finished, check build result!

build_message Deploying multiarch manifests
deploy_multiarch_manifests
build_message Deployment for multiarch manifests finished, check build result!

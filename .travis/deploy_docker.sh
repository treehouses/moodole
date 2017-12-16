#!/usr/bin/env bash

source ./.travis/travis_utils.sh

build_message Preparing builds...
prepare_package

build_message Build x86 image started...
deploy_x86
build_message Buil x86 image finished, check build result!

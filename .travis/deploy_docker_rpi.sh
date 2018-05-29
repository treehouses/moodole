#!/usr/bin/env bash

####### Parse commandline arguments  #####################
for i in "$@"
do
case $i in
    -u=*|--duser=*)
      DOCKER_USER="${i#*=}"
      ;;
    -k=*|--dpass=*)
      DOCKER_PASS="${i#*=}"
      ;;
    -b=*|--branch=*)
        BRANCH_INPUT="${i#*=}"
        ;;
    -c=*|--commit=*)
        COMMIT_INPUT="${i#*=}"
        ;;
    *)
    echo "usage: ./deploy_docker_rpi.sh -b=<branch-name>|--branch=<branch-name>"
    echo "usage: ./deploy_docker_rpi.sh -c=<commit-sha>|--commit=<commit-sha>"
    echo "usage: ./deploy_docker_rpi.sh -u=<docker-user-name>|--duser=<docker-user-name>"
    echo "usage: ./deploy_docker_rpi.sh -k=<docker-password>|--dpass=<docker-password>"
    exit 1;
    ;;
esac
done
##########################################################

build_message(){
    # $1 = build message
    echo
    echo =========BUILD MESSAGE=========
    echo "$@"
    echo ===============================
    echo
}

prepare_package_arm(){
	BRANCH=$BRANCH_INPUT
	COMMIT=${COMMIT_INPUT::8}
	FINGERPRINT="moodole-$RANDOM_FINGERPRINT"
	TEST_DIRECTORY=/tmp/"$FINGERPRINT"
	REPO_LINK="https://github.com/treehouses/moodole.git"
	FOOTPRINT_NAME=$VERSION-$BRANCH-$COMMIT
}

build_message Preparing builds...
prepare_package_arm

build_message setting up build utils...
source ./.travis/travis_utils.sh
prepare_package

build_message Build ARM image started...
deploy_arm
build_message Build ARM image finished, check build result!

build_message Build ARM Apache image started...
deploy_arm_apache
build_message Build ARM Apache image finished, check build result!

build_message Build ARM Alpine image started...
deploy_arm_alpine
build_message Build ARM Alpine image finished, check build result!

build_message Build ARM64 image started...
deploy_arm64
build_message Build ARM64 image finished, check build result!

build_message Build ARM64 Apache image started...
deploy_arm64_apache
build_message Build ARM64 Apache image finished, check build result!

build_message Build ARM64 Alpine image started...
deploy_arm64_alpine
build_message Build ARM64 Alpine image finished, check build result!

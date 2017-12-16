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
	COMMIT=$COMMIT_INPUT
	RANDOM_FINGERPRINT=$(random_generator)
	FINGERPRINT="moodole-$RANDOM_FINGERPRINT"
	TEST_DIRECTORY=/tmp/"$FINGERPRINT"
	REPO_LINK="https://github.com/ole-vi/moodole.git"
	FOOTPRINT_NAME=$VERSION-$BRANCH-$COMMIT
	FOOTPRINT=~/travis-build/$FOOTPRINT_NAME
}

clone_branch(){
    cd /tmp && rm -rf $FINGERPRINT;
    git clone -b "$BRANCH" "$REPO_LINK" "$FINGERPRINT" && cd "$FINGERPRINT" || exit
    ls
    git checkout "$COMMIT"
}

random_generator(){
    awk -v min=10000000 -v max=99999999 'BEGIN{srand(); print int(min+rand()*(max-min+1))}'
}

build_message Preparing builds...
prepare_package_arm

build_message Cloning commits...
clone_branch

build_message setting up build utils...
source ./.travis/travis_utils.sh

build_message Creating footprint...
create_footprint_moodole

build_message Build ARM image started...
deploy_arm
build_message Buil ARM image finished, check build result!

build_message Peform postconditions on build machine..
remove_temporary_folders
create_footprint_moodole

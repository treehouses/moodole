#!/usr/bin/env bash

build_message(){
    # $1 = build message
    echo
    echo =========BUILD MESSAGE=========
    echo "$@"
    echo ===============================
    echo
}

login_docker(){
    docker login --username=$DOCKER_USER --password=$DOCKER_PASS
}

prepare_package(){
	export DOCKER_ORG=treehouses
	export DOCKER_REPO=moodle
	export VERSION=$(cat package.json | grep version | awk '{print$2}' | awk '{print substr($0, 2, length($0) - 3)}')
	export BRANCH=$TRAVIS_BRANCH
	export COMMIT=${TRAVIS_COMMIT::8}
	export X86_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:$VERSION-$BRANCH-$COMMIT
	export X86_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:latest
	export ARM_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:rpi-$VERSION-$BRANCH-$COMMIT
	export ARM_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:rpi-latest
}

package_x86(){
	build_message processing $X86_DOCKER_NAME
	docker build 3.4/x86/ -t $X86_DOCKER_NAME
	build_message done processing $X86_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $X86_DOCKER_NAME_LATEST
		docker tag $X86_DOCKER_NAME $X86_DOCKER_NAME_LATEST
		build_message done processing $X86_DOCKER_NAME_LATEST
	fi
}

package_arm(){
	build_message processing $ARM_DOCKER_NAME
	docker build 3.4/arm/ -t $ARM_DOCKER_NAME
	build_message done processing $ARM_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $ARM_DOCKER_NAME_LATEST
		docker tag $ARM_DOCKER_NAME $ARM_DOCKER_NAME_LATEST
		build_message done processing $ARM_DOCKER_NAME_LATEST
	fi
}

push_x86(){
	build_message pushing $X86_DOCKER_NAME
	docker push $X86_DOCKER_NAME
	build_message done pushing $X86_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $X86_DOCKER_NAME_LATEST
		docker push $X86_DOCKER_NAME_LATEST
		build_message done pushing $X86_DOCKER_NAME_LATEST
	fi
}

push_arm(){
	build_message pushing $ARM_DOCKER_NAME
	docker push $ARM_DOCKER_NAME
	build_message done pushing $ARM_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $ARM_DOCKER_NAME_LATEST
		docker push $ARM_DOCKER_NAME_LATEST
		build_message done pushing $ARM_DOCKER_NAME_LATEST
	fi
}

deploy_x86(){
	login_docker
	package_x86
	push_x86
}

deploy_arm(){
	login_docker
	package_arm
	push_arm
}

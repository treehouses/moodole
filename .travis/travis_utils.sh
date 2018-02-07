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
	DOCKER_ORG=treehouses
	DOCKER_REPO=moodle
	VERSION=$(cat package.json | grep version | awk '{print$2}' | awk '{print substr($0, 2, length($0) - 3)}')
	if [ -z "$BRANCH" ]; then
		BRANCH=$TRAVIS_BRANCH
	fi
	if [ -z "$COMMIT" ]; then
		COMMIT=${TRAVIS_COMMIT::8}
	fi
	X86_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:$VERSION-$BRANCH-$COMMIT
	X86_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:latest
	X86_DOCKER_APACHE_NAME=$DOCKER_ORG/$DOCKER_REPO:apache-$VERSION-$BRANCH-$COMMIT
	X86_DOCKER_APACHE_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:apache-latest
	X86_DOCKER_ALPINE_NAME=$DOCKER_ORG/$DOCKER_REPO:alpine-$VERSION-$BRANCH-$COMMIT
	X86_DOCKER_ALPINE_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:alpine-latest
	ARM_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:rpi-$VERSION-$BRANCH-$COMMIT
	ARM_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:rpi-latest
	ARM_DOCKER_APACHE_NAME=$DOCKER_ORG/$DOCKER_REPO:rpi-apache-$VERSION-$BRANCH-$COMMIT
	ARM_DOCKER_APACHE_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:rpi-apache-latest
	ARM_DOCKER_ALPINE_NAME=$DOCKER_ORG/$DOCKER_REPO:rpi-alpine-$VERSION-$BRANCH-$COMMIT
	ARM_DOCKER_ALPINE_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:rpi-alpine-latest
}

remove_temporary_folders(){
	rm -rf "$TEST_DIRECTORY"
}

create_footprint_moodole() {
  echo $(date +%Y-%m-%d.%H-%M-%S) from moodole >> $FOOTPRINT
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

package_x86_apache(){
	build_message processing $X86_DOCKER_APACHE_NAME
	docker build 3.4_apache/x86/ -t $X86_DOCKER_APACHE_NAME
	build_message done processing $X86_DOCKER_APACHE_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $X86_DOCKER_APACHE_NAME_LATEST
		docker tag $X86_DOCKER_APACHE_NAME $X86_DOCKER_APACHE_NAME_LATEST
		build_message done processing $X86_DOCKER_APACHE_NAME_LATEST
	fi
}

package_x86_alpine(){
	build_message processing $X86_DOCKER_ALPINE_NAME
	docker build 3.4/x86_alpine/ -t $X86_DOCKER_ALPINE_NAME
	build_message done processing $X86_DOCKER_ALPINE_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $X86_DOCKER_ALPINE_NAME_LATEST
		docker tag $X86_DOCKER_ALPINE_NAME $X86_DOCKER_ALPINE_NAME_LATEST
		build_message done processing $X86_DOCKER_ALPINE_NAME_LATEST
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

package_arm_apache(){
	build_message processing $ARM_DOCKER_APACHE_NAME
	docker build 3.4/arm/ -t $ARM_DOCKER_APACHE_NAME
	build_message done processing $ARM_DOCKER_APACHE_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $ARM_DOCKER_APACHE_NAME_LATEST
		docker tag $ARM_DOCKER_APACHE_NAME $ARM_DOCKER_APACHE_NAME_LATEST
		build_message done processing $ARM_DOCKER_APACHE_NAME_LATEST
	fi
}

package_arm_alpine(){
	build_message processing $ARM_DOCKER_ALPINE_NAME
	docker build 3.4/arm_alpine/ -t $ARM_DOCKER_ALPINE_NAME
	build_message done processing $ARM_DOCKER_ALPINE_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $ARM_DOCKER_ALPINE_NAME_LATEST
		docker tag $ARM_DOCKER_ALPINE_NAME $ARM_DOCKER_ALPINE_NAME_LATEST
		build_message done processing $ARM_DOCKER_ALPINE_NAME_LATEST
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

push_x86_apache(){
	build_message pushing $X86_DOCKER_APACHE_NAME
	docker push $X86_DOCKER_APACHE_NAME
	build_message done pushing $X86_DOCKER_APACHE_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $X86_DOCKER_APACHE_NAME_LATEST
		docker push $X86_DOCKER_APACHE_NAME_LATEST
		build_message done pushing $X86_DOCKER_APACHE_NAME_LATEST
	fi
}

push_x86_alpine(){
	build_message pushing $X86_DOCKER_ALPINE_NAME
	docker push $X86_DOCKER_ALPINE_NAME
	build_message done pushing $X86_DOCKER_ALPINE_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $X86_DOCKER_ALPINE_NAME_LATEST
		docker push $X86_DOCKER_ALPINE_NAME_LATEST
		build_message done pushing $X86_DOCKER_ALPINE_NAME_LATEST
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

push_arm_apache(){
	build_message pushing $ARM_DOCKER_APACHE_NAME
	docker push $ARM_DOCKER_APACHE_NAME
	build_message done pushing $ARM_DOCKER_APACHE_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $ARM_DOCKER_APACHE_NAME_LATEST
		docker push $ARM_DOCKER_APACHE_NAME_LATEST
		build_message done pushing $ARM_DOCKER_APACHE_NAME_LATEST
	fi
}

push_arm_alpine(){
	build_message pushing $ARM_DOCKER_ALPINE_NAME
	docker push $ARM_DOCKER_ALPINE_NAME
	build_message done pushing $ARM_DOCKER_ALPINE_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $ARM_DOCKER_ALPINE_NAME_LATEST
		docker push $ARM_DOCKER_ALPINE_NAME_LATEST
		build_message done pushing $ARM_DOCKER_ALPINE_NAME_LATEST
	fi
}

deploy_x86(){
	login_docker
	package_x86
	push_x86
}

deploy_x86_apache(){
	login_docker
	package_x86_apache
	push_x86_apache
}

deploy_x86_alpine(){
	login_docker
	package_x86_alpine
	push_x86_alpine
}

deploy_arm(){
	login_docker
	package_arm
	push_arm
}

deploy_arm_apache(){
	login_docker
	package_arm_apache
	push_arm_apache
}

deploy_arm_alpine(){
	login_docker
	package_arm_alpine
	push_arm_alpine
}

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
	DOCKER_REPO=moodle-tags
	VERSION=$(cat package.json | grep version | awk '{print$2}' | awk '{print substr($0, 2, length($0) - 3)}')
	if [ -z "$BRANCH" ]; then
		BRANCH=$TRAVIS_BRANCH
	fi
	if [ -z "$COMMIT" ]; then
		COMMIT=${TRAVIS_COMMIT::8}
	fi
	AMD64_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:$VERSION-$BRANCH-$COMMIT
	AMD64_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:latest
	AMD64_DOCKER_APACHE_NAME=$DOCKER_ORG/$DOCKER_REPO:apache-$VERSION-$BRANCH-$COMMIT
	AMD64_DOCKER_APACHE_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:apache-latest
	AMD64_DOCKER_ALPINE_NAME=$DOCKER_ORG/$DOCKER_REPO:alpine-$VERSION-$BRANCH-$COMMIT
	AMD64_DOCKER_ALPINE_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:alpine-latest
	ARM_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:rpi-$VERSION-$BRANCH-$COMMIT
	ARM_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:rpi-latest
	ARM_DOCKER_APACHE_NAME=$DOCKER_ORG/$DOCKER_REPO:rpi-apache-$VERSION-$BRANCH-$COMMIT
	ARM_DOCKER_APACHE_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:rpi-apache-latest
	ARM_DOCKER_ALPINE_NAME=$DOCKER_ORG/$DOCKER_REPO:rpi-alpine-$VERSION-$BRANCH-$COMMIT
	ARM_DOCKER_ALPINE_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:rpi-alpine-latest
}

package_amd64(){
	build_message processing $AMD64_DOCKER_NAME
	docker build 3.4/amd64/ -t $AMD64_DOCKER_NAME
	build_message done processing $AMD64_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $AMD64_DOCKER_NAME_LATEST
		docker tag $AMD64_DOCKER_NAME $AMD64_DOCKER_NAME_LATEST
		build_message done processing $AMD64_DOCKER_NAME_LATEST
	fi
}

package_amd64_apache(){
	build_message processing $AMD64_DOCKER_APACHE_NAME
	docker build 3.4_apache/amd64/ -t $AMD64_DOCKER_APACHE_NAME
	build_message done processing $AMD64_DOCKER_APACHE_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $AMD64_DOCKER_APACHE_NAME_LATEST
		docker tag $AMD64_DOCKER_APACHE_NAME $AMD64_DOCKER_APACHE_NAME_LATEST
		build_message done processing $AMD64_DOCKER_APACHE_NAME_LATEST
	fi
}

package_amd64_alpine(){
	build_message processing $AMD64_DOCKER_ALPINE_NAME
	docker build 3.4/amd64_alpine/ -t $AMD64_DOCKER_ALPINE_NAME
	build_message done processing $AMD64_DOCKER_ALPINE_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $AMD64_DOCKER_ALPINE_NAME_LATEST
		docker tag $AMD64_DOCKER_ALPINE_NAME $AMD64_DOCKER_ALPINE_NAME_LATEST
		build_message done processing $AMD64_DOCKER_ALPINE_NAME_LATEST
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

push_amd64(){
	build_message pushing $AMD64_DOCKER_NAME
	docker push $AMD64_DOCKER_NAME
	build_message done pushing $AMD64_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $AMD64_DOCKER_NAME_LATEST
		docker push $AMD64_DOCKER_NAME_LATEST
		build_message done pushing $AMD64_DOCKER_NAME_LATEST
	fi
}

push_amd64_apache(){
	build_message pushing $AMD64_DOCKER_APACHE_NAME
	docker push $AMD64_DOCKER_APACHE_NAME
	build_message done pushing $AMD64_DOCKER_APACHE_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $AMD64_DOCKER_APACHE_NAME_LATEST
		docker push $AMD64_DOCKER_APACHE_NAME_LATEST
		build_message done pushing $AMD64_DOCKER_APACHE_NAME_LATEST
	fi
}

push_amd64_alpine(){
	build_message pushing $AMD64_DOCKER_ALPINE_NAME
	docker push $AMD64_DOCKER_ALPINE_NAME
	build_message done pushing $AMD64_DOCKER_ALPINE_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $AMD64_DOCKER_ALPINE_NAME_LATEST
		docker push $AMD64_DOCKER_ALPINE_NAME_LATEST
		build_message done pushing $AMD64_DOCKER_ALPINE_NAME_LATEST
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

deploy_amd64(){
	login_docker
	package_amd64
	push_amd64
}

deploy_amd64_apache(){
	login_docker
	package_amd64_apache
	push_amd64_apache
}

deploy_amd64_alpine(){
	login_docker
	package_amd64_alpine
	push_amd64_alpine
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

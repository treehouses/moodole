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

prepare_multiarch_manifest_tool(){
  build_message Prepare Manifest tool
  sudo wget -O /usr/local/bin/manifest_tool https://github.com/estesp/manifest-tool/releases/download/v0.7.0/manifest-tool-linux-amd64
  sudo chmod +x /usr/local/bin/manifest_tool
  mkdir -p /tmp/MA_manifests
}

prepare_yq(){
  build_message Prepare yq
  sudo wget -O /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/1.14.1/yq_linux_amd64
  sudo chmod +x /usr/local/bin/yq
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
	AMD64_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:amd64-latest
	AMD64_DOCKER_APACHE_NAME=$DOCKER_ORG/$DOCKER_REPO:amd64-apache-$VERSION-$BRANCH-$COMMIT
	AMD64_DOCKER_APACHE_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:amd64-apache-latest
	AMD64_DOCKER_ALPINE_NAME=$DOCKER_ORG/$DOCKER_REPO:amd64-alpine-$VERSION-$BRANCH-$COMMIT
	AMD64_DOCKER_ALPINE_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:amd64-alpine-latest
	ARM_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:arm-$VERSION-$BRANCH-$COMMIT
	ARM_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:arm-latest
	ARM_DOCKER_APACHE_NAME=$DOCKER_ORG/$DOCKER_REPO:arm-apache-$VERSION-$BRANCH-$COMMIT
	ARM_DOCKER_APACHE_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:arm-apache-latest
	ARM_DOCKER_ALPINE_NAME=$DOCKER_ORG/$DOCKER_REPO:arm-alpine-$VERSION-$BRANCH-$COMMIT
	ARM_DOCKER_ALPINE_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:arm-alpine-latest	
	ARM64_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:arm64-$VERSION-$BRANCH-$COMMIT
	ARM64_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:arm64-latest
	ARM64_DOCKER_APACHE_NAME=$DOCKER_ORG/$DOCKER_REPO:arm64-apache-$VERSION-$BRANCH-$COMMIT
	ARM64_DOCKER_APACHE_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:arm64-apache-latest
	ARM64_DOCKER_ALPINE_NAME=$DOCKER_ORG/$DOCKER_REPO:arm64-alpine-$VERSION-$BRANCH-$COMMIT
	ARM64_DOCKER_ALPINE_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:arm64-alpine-latest
	
	prepare_multiarch_manifest_tool
	prepare_yq
	
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

ackage_arm64(){
	build_message processing $ARM64_DOCKER_NAME
	docker build 3.4/arm64/ -t $ARM64_DOCKER_NAME
	build_message done processing $ARM64_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $ARM64_DOCKER_NAME_LATEST
		docker tag $ARM64_DOCKER_NAME $ARM64_DOCKER_NAME_LATEST
		build_message done processing $ARM64_DOCKER_NAME_LATEST
	fi
}

package_arm64_apache(){
	build_message processing $ARM64_DOCKER_APACHE_NAME
	docker build 3.4/arm64/ -t $ARM64_DOCKER_APACHE_NAME
	build_message done processing $ARM64_DOCKER_APACHE_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $ARM64_DOCKER_APACHE_NAME_LATEST
		docker tag $ARM64_DOCKER_APACHE_NAME $ARM64_DOCKER_APACHE_NAME_LATEST
		build_message done processing $ARM64_DOCKER_APACHE_NAME_LATEST
	fi
}

package_arm64_alpine(){
	build_message processing $ARM64_DOCKER_ALPINE_NAME
	docker build 3.4/arm64_alpine/ -t $ARM64_DOCKER_ALPINE_NAME
	build_message done processing $ARM64_DOCKER_ALPINE_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $ARM64_DOCKER_ALPINE_NAME_LATEST
		docker tag $ARM64_DOCKER_ALPINE_NAME $ARM64_DOCKER_ALPINE_NAME_LATEST
		build_message done processing $ARM64_DOCKER_ALPINE_NAME_LATEST
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

push_arm64(){
	build_message pushing $ARM64_DOCKER_NAME
	docker push $ARM64_DOCKER_NAME
	build_message done pushing $ARM64_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $ARM64_DOCKER_NAME_LATEST
		docker push $ARM64_DOCKER_NAME_LATEST
		build_message done pushing $ARM64_DOCKER_NAME_LATEST
	fi
}

push_arm64_apache(){
	build_message pushing $ARM64_DOCKER_APACHE_NAME
	docker push $ARM64_DOCKER_APACHE_NAME
	build_message done pushing $ARM64_DOCKER_APACHE_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $ARM64_DOCKER_APACHE_NAME_LATEST
		docker push $ARM64_DOCKER_APACHE_NAME_LATEST
		build_message done pushing $ARM64_DOCKER_APACHE_NAME_LATEST
	fi
}

push_arm64_alpine(){
	build_message pushing $ARM64_DOCKER_ALPINE_NAME
	docker push $ARM64_DOCKER_ALPINE_NAME
	build_message done pushing $ARM64_DOCKER_ALPINE_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $ARM64_DOCKER_ALPINE_NAME_LATEST
		docker push $ARM64_DOCKER_ALPINE_NAME_LATEST
		build_message done pushing $ARM64_DOCKER_ALPINE_NAME_LATEST
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

deploy_arm64(){
	login_docker
	package_arm64
	push_arm64
}

deploy_arm64_apache(){
	login_docker
	package_arm64_apache
	push_arm64_apache
}

deploy_arm64_alpine(){
	login_docker
	package_arm64_alpine
	push_arm64_alpine
}

#this will be the latest tag
create_multiarch_manifest_moodole_apache(){
    build_message Creating moodole Multiarch Manifests for latest
    if [ "$BRANCH" = "master" ]
    then
        # $1: latest arm
        # $2: latest amd64   
        # $3: latest arm64
        yq n image treehouses/moodle:latest | \
        yq w - manifests[0].image $1 | \
        yq w - manifests[0].platform.architecture arm | \
        yq w - manifests[0].platform.os linux | \
        yq w - manifests[1].image $2 | \
        yq w - manifests[1].platform.architecture amd64 | \
        yq w - manifests[1].platform.os linux | \
        yq w - manifests[2].image $3 | \
        yq w - manifests[2].platform.architecture arm64 | \
        yq w - manifests[2].platform.os linux | \
        tee /tmp/MA_manifests/MA_moodole_latest.yaml
    else
        build_message Branch is Not master so no need to create Multiarch manifests for moodole for latest.
    fi
}

#this will be the nginx tag
create_multiarch_manifest_moodole_nginx(){
    build_message Creating moodole Multiarch Manifests for nginx
    if [ "$BRANCH" = "master" ]
    then
        # $1: latest arm
        # $2: latest amd64   
        # $3: latest arm64
        yq n image treehouses/moodle:nginx | \
        yq w - manifests[0].image $1 | \
        yq w - manifests[0].platform.architecture arm | \
        yq w - manifests[0].platform.os linux | \
        yq w - manifests[1].image $2 | \
        yq w - manifests[1].platform.architecture amd64 | \
        yq w - manifests[1].platform.os linux | \
        yq w - manifests[2].image $3 | \
        yq w - manifests[2].platform.architecture arm64 | \
        yq w - manifests[2].platform.os linux | \
        tee /tmp/MA_manifests/MA_moodole_nginx.yaml
    else
        build_message Branch is Not master so no need to create Multiarch manifests for moodole for nginx.
    fi
}

#this will be the alpine tag
create_multiarch_manifest_moodole_alpine(){
    build_message Creating moodole Multiarch Manifests for alpine
    if [ "$BRANCH" = "master" ]
    then
        # $1: latest arm
        # $2: latest amd64   
        # $3: latest arm64
        yq n image treehouses/moodle:alpine | \
        yq w - manifests[0].image $1 | \
        yq w - manifests[0].platform.architecture arm | \
        yq w - manifests[0].platform.os linux | \
        yq w - manifests[1].image $2 | \
        yq w - manifests[1].platform.architecture amd64 | \
        yq w - manifests[1].platform.os linux | \
        yq w - manifests[2].image $3 | \
        yq w - manifests[2].platform.architecture arm64 | \
        yq w - manifests[2].platform.os linux | \
        tee /tmp/MA_manifests/MA_moodole_alpine.yaml
    else
        build_message Branch is Not master so no need to create Multiarch manifests for moodole for alpine.
    fi
}

push_multiarch_manifests(){
    build_message Pushing Multiarch Manifests to cloud
    if [ "$BRANCH" = "master" ]
    then
        manifest_tool push from-spec /tmp/MA_manifests/MA_moodole_latest.yaml
        manifest_tool push from-spec /tmp/MA_manifests/MA_moodole_nginx.yaml
        manifest_tool push from-spec /tmp/MA_manifests/MA_moodole_alpine.yaml
        build_message Successfully Pushed Multiarch Manifests to cloud
    else
         build_message Branch is Not master so no need to Push Multiarch Manifests to cloud
    fi
}

deploy_multiarch_manifests(){
        create_multiarch_manifest_moodole_apache $ARM_DOCKER_APACHE_NAME_LATEST $AMD64_DOCKER_APACHE_NAME_LATEST $ARM64_DOCKER_APACHE_NAME_LATEST
        create_multiarch_manifest_moodole_nginx $ARM_DOCKER_NAME_LATEST $AMD64_DOCKER_NAME_LATEST $ARM64_DOCKER_NAME_LATEST
        create_multiarch_manifest_moodole_alpine $ARM_DOCKER_ALPINE_NAME_LATEST $AMD64_DOCKER_ALPINE_NAME_LATEST $ARM64_DOCKER_ALPINE_NAME_LATEST
        push_multiarch_manifests
}

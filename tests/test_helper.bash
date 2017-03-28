#!/usr/bin/env bash

tag=$(git describe --exact-match 2>/dev/null || echo latest)

REPO_OWNER=koding
REPO_NAME=base
IMAGE_NAME=$REPO_OWNER/$REPO_NAME:$tag

koding-base() {
	docker run --rm --tty "$IMAGE_NAME" "$@"
}

unset tag

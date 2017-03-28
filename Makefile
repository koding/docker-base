.PHONY: all build test unit-tests bats rm-image clean

REPO_OWNER := koding
REPO_NAME := base

IMAGE_TAG := $(shell git describe --exact-match 2>/dev/null || echo latest)
IMAGE_NAME := $(REPO_OWNER)/$(REPO_NAME):$(IMAGE_TAG)

all: test

build:
	@echo "+ $@"
	docker build --no-cache --tag $(IMAGE_NAME) $(CURDIR)

test: build unit-tests

unit-tests: bats clean
	@echo "+ $@"
	@LC_ALL=C $(TMPDIR)/bin/bats --tap tests

bats:
	@echo "+ Downloading $@"
	$(eval TMPDIR := $(shell mktemp -d /tmp/bats.XXXXXXXX))
	git clone https://github.com/sstephenson/bats.git $(TMPDIR)
	@echo "> Downloaded into $(TMPDIR)"

rm-image:
ifneq ($(shell docker images --quiet $(IMAGE_NAME)),)
	@echo "+ $@"
	docker rmi --force $(IMAGE_NAME)
endif

clean:
	@echo "+ $@"
	$(RM) -r /tmp/bats.*

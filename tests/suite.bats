#!/usr/bin/env bats

load test_helper

@test "System version is correct" {
	run koding-base /bin/cat /etc/lsb-release
	[[ $status -eq 0 ]]
	[[ ${lines[1]} =~ "=16.04" ]]
}

@test "Repo list is correct" {
	run koding-base /bin/grep nginx/stable --directories=recurse \
		/etc/apt/sources.list.d
	[[ $status -eq 0 ]]
}

@test "No missing dist package" {
	run koding-base /usr/bin/dpkg-query -W \
		bc \
		git-core \
		htop \
		build-essential \
		curl \
		wget \
		unzip \
		nginx \
		mongodb-clients \
		postgresql-client \
		redis-tools \
		graphicsmagick \
		python-pip \
		rlwrap \
		libev-dev \
		libev4 \
		libjpeg-dev \
		libnotify-bin \
		libxml2-dev \
		libssl-dev \
		libgif-dev \
		libcairo2-dev \
		software-properties-common
	[[ $status -eq 0 ]]
}

@test "coffee is installed" {
	run koding-base sh -c "command -v coffee"
	[[ $status -eq 0 ]]
}

@test "go is installed" {
	run koding-base sh -c "command -v go"
	[[ $status -eq 0 ]]
}

@test "jq is installed" {
	run koding-base sh -c "command -v jq"
	[[ $status -eq 0 ]]
}

@test "node is installed" {
	run koding-base sh -c "command -v node"
	[[ $status -eq 0 ]]
}

@test "npm is installed" {
	run koding-base sh -c "command -v npm"
	[[ $status -eq 0 ]]
}

@test "supervisor is installed" {
	run koding-base sh -c "command -v supervisord"
	[[ $status -eq 0 ]]
}

@test "coffee run OK (with correct version)" {
	run koding-base /usr/local/bin/coffee -v
	[[ $status -eq 0 ]]
 	[[ $output =~ 1.12 ]]
}

@test "go run OK (with correct version)" {
	run koding-base /usr/local/bin/go version
	[[ $status -eq 0 ]]
	[[ $output =~ 1.8 ]]
}

@test "jq run OK (with correct version)" {
	run koding-base /usr/local/bin/jq --version
	[[ $status -eq 0 ]]
	[[ $output =~ 1.5 ]]
}

@test "node run OK (with correct version)" {
	run koding-base /usr/local/bin/node -v
	[[ $status -eq 0 ]]
	[[ $output =~ 6.9.4 ]]
}

@test "npm run OK (with correct version)" {
 	run koding-base /usr/local/bin/npm -v
	[[ $status -eq 0 ]]
	[[ $output == 4.* ]]
}

@test "supervisor run OK" {
	run koding-base /usr/local/bin/supervisord -v
	[[ $status -eq 0 ]]
}

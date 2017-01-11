FROM ubuntu:14.04
MAINTAINER Sonmez Kartal <sonmez@koding.com>

RUN apt-get update && \
    apt-get install --yes --quiet=2 software-properties-common && \
    add-apt-repository --yes ppa:nginx/stable && \
    apt-get update && \
    apt-get --yes --quiet=2 install \
            bc htop build-essential curl wget unzip git-core \
            nginx mongodb-clients postgresql-client redis-tools \
            graphicsmagick python-pip rlwrap \
            libev-dev libev4 libnotify-bin libxml2-dev libssl-dev \
            libgif-dev libjpeg-dev libcairo2-dev

ENV GO_VERSION="1.7.1"
ENV GO_NAME="go${GO_VERSION}"
ENV GO_TARBALL="${GO_NAME}.linux-amd64.tar.gz"
ENV GO_DIST_URL="https://storage.googleapis.com/golang/${GO_TARBALL}"

RUN curl --silent $GO_DIST_URL | \
    tar --extract --gzip --directory /usr/local && \
    ln -s /usr/local/go/bin/* /usr/local/bin

ENV NODE_VERSION="v6.9.4"
ENV NODE_NAME="node-$NODE_VERSION-linux-x64"
ENV NODE_TARBALL="$NODE_NAME.tar.xz"
ENV NODE_DIST_URL="https://nodejs.org/dist/$NODE_VERSION/$NODE_TARBALL"

RUN curl --silent --location $NODE_DIST_URL | \
    tar --extract --xz --strip-components=1 \
        --directory /usr/local/ \
        $NODE_NAME/bin \
        $NODE_NAME/include \
        $NODE_NAME/lib \
        $NODE_NAME/share

ENV NPM_VERSION="4.*" \
    COFFEE_SCRIPT_VERSION="1.12"

RUN npm install --global npm@$NPM_VERSION

RUN npm install --global \
        coffee-script@$COFFEE_SCRIPT_VERSION \
        gulp

RUN pip install supervisor

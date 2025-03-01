FROM node:{{ version }}-slim
LABEL maintainer="https://github.com/Rp70/docker-node"

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

# Installing some tools
RUN set -ex \
  && apt update \
  && apt install -y curl

# Grab gosu for easy step-down from root
ENV GOSU_VERSION 1.17
RUN set -ex \
  && curl -sSLo /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
  && chmod +x /usr/local/bin/gosu \
  && gosu nobody true

# Copy entrypoint files
COPY files/docker-entrypoint-init.d/ /docker-entrypoint-init.d/
COPY files/entrypoint.sh /entrypoint.sh
RUN set -ex && \
  chmod +x /entrypoint.sh

# Clean up
RUN set -ex && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/entrypoint.sh"]
CMD ["startup"]

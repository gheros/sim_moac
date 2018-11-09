FROM ubuntu:18.04
MAINTAINER Yifan Wang <heavenstar@gmail.com>

VOLUME /scs_data

RUN apt-get update \
    && apt-get install -y iputils-ping \
    && apt-get install lsof -y \
    && apt-get install net-tools -y \
    && apt-get install curl -y

# setup /scs_data directory
RUN mkdir -p /scs_data/scs/config
RUN mkdir -p /scs_data/scs/data
RUN mkdir -p /scs_data/scs/log

# install moac-scs and moac ipfs-monkey
COPY moac-scs/build/bin/scsserver /usr/local/sbin/
# In prod, use volume instead of copying config file from code branch
# COPY config/userconfig_prod.json /scs_data/scs/userconfig.json
COPY addins/ipfs/docker/wait-for-it.sh /usr/local/sbin/

WORKDIR /scs_data/scs

# monkey
EXPOSE 18080
FROM pmohan/centos-squid:v1

MAINTAINER Prabu Mohan <prabu.mohan@outlook.com>
EXPOSE 3128/tcp
ENV SQUID_VERSION=3.5.27 \
    SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy
COPY ./hosts /etc/hosts

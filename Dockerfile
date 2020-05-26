FROM feduxorg/centos:latest
MAINTAINER fedux_org

# ENV http_proxy http://172.17.42.1:3128
# ENV https_proxy https://172.17.42.1:3128

# Install base stuff.
RUN groupadd -g 1000 squid \
  && useradd -u 1000 squid -g 1000 \
  && yum -y install squid \
  && systemctl enable squid \
  && yum clean -y all

# Expose directories
VOLUME ["/var/log/squid"]

# Expose ports
EXPOSE 8080
EXPOSE 3128


IMAGE_NAME := pmohan/centos-squid
IMAGE_TAG := v5
CONTAINER_NAME := $(Container_Name)
ENV_FILE_NAME := squid
HOST_PORT := $(Port)
ENV:=$(Env)
#APP_DIR := '/apps/dbuild'

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

MAKE_DIR := $(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))


.PHONY: all build clean create kill start stop restart shell docker_ip
all:create 

build:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .
clean:
	docker images $(IMAGE_NAME) | grep -q $(IMAGE_TAG) && docker rmi $(IMAGE_NAME):$(IMAGE_TAG) || true
create:
	docker run --privileged --name $(CONTAINER_NAME)  -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p $(HOST_PORT):3128 -v $(MAKE_DIR)/squid_$(ENV).conf:/etc/squid/squid.conf -v $(MAKE_DIR)/hosts_$(ENV):/etc/hosts -v $(MAKE_DIR)/logs/:/var/log/squid/ $(IMAGE_NAME):$(IMAGE_TAG)

kill:
	docker stop $(CONTAINER_NAME) && docker rm $(CONTAINER_NAME)

start:
	docker start $(CONTAINER_NAME)
stop:
	docker stop $(CONTAINER_NAME)
restart:
	docker exec -t $(CONTAINER_NAME) systemctl restart squid
shell:
	docker exec -it $(CONTAINER_NAME) bash
docker_ip:
	@ip addr show docker0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1


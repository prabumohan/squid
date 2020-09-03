#!/bin/bash
curl http://10.214.0.119/stats/html5/dashboard/CF/hosts -o hosts
echo $?

if grep  "hosts_CF_v1" docker-compose.yml
then
    echo "found hosts_CF_v1"
    sed -i 's/hosts_CF_v1/hosts_CF_v2/g' docker-compose.yml
    docker stack deploy -c docker-compose.yml Pool_1
 else
    echo "not found hosts_v1"
    sed -i 's/hosts_CF_v2/hosts_CF_v1/g' docker-compose.yml
    docker stack deploy -c docker-compose.yml Pool_1
 fi


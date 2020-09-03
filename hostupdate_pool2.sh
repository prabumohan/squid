#!/bin/bash
curl http://10.214.0.119/stats/html5/dashboard/CF/hosts -o hosts
echo $?
if grep  "hosts_CF_v1" docker-compose-pool2.yml
then
    echo "found hosts_CF_v1"
    sed -i 's/hosts_CF_v1/hosts_CF_v2/g' docker-compose-pool2.yml
    docker stack deploy -c docker-compose-pool2.yml Pool_2
    docker config rm Pool_2_hosts_CF_v1

 else
    echo "not found hosts_v1"
    sed -i 's/hosts_CF_v2/hosts_CF_v1/g' docker-compose-pool2.yml
    docker stack deploy -c docker-compose-pool2.yml Pool_2
    docker config rm Pool_2_hosts_CF_v2

fi


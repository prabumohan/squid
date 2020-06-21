#!/bin/bash
curl http://10.214.0.119/stats/html5/dashboard/CF/hosts -o hosts
#sed -i 's/hosts_v1/hosts/g' docker-compose-test.yml
echo $?
#if [ $? -eq 0 ]
#    then
if grep  "hosts_CF_v1" docker-compose.yml
then
    echo "found hosts_CF_v1"
    sed -i 's/hosts_CF_v1/hosts_CF_v2/g' docker-compose.yml
    exec docker config rm Pool_1_hosts_CF_v1
    exec docker stack deploy -c docker-compose.yml Pool_1
 else
    echo "not found hosts_v1"
    sed -i 's/hosts_CF_v2/hosts_CF_v1/g' docker-compose.yml
    exec docker config rm Pool_1_hosts_CF_v2
    exec docker stack deploy -c docker-compose.yml Pool_1
fi

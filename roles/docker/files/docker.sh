#!/bin/bash
HOSTS="192.168.3.101 192.168.3.102 192.168.3.103"
DOCKER_FILE="containerd  containerd-shim  ctr docker  dockerd  docker-init  docker-proxy runc"
for i in $HOSTS ; do
    for a in $DOCKER_FILE ; do
        scp $a root@$i:/usr/bin/
    done

    if [ ! -d /etc/docker ] ; then
        mkdir /etc/docker
    fi

    scp daemon.json /etc/docker
    scp docker.service /usr/lib/systemd/system/docker.service
    systemctl daemon-reload
    systemctl enable docker
    systemctl start docker
done

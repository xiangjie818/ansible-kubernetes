#!/bin/bash
config_file=/opt/kubernetes/cfg/kube-apiserver
host_ip=$(hostname -i)

cat $config_file | grep HOST_IP
if [ $? = 0 ] ; then
   sed -i "s@HOST_IP@$host_ip@g" $config_file
fi

#!/bin/bash
SELINUX=$(getenforce)
if [ $SELINUX != Disabled ] ; then
   sed -i s/SELINUX=enforcing/SELINUX=disabled/ /etc/selinux/config
fi

systemctl disable firewalld
iptables -F
iptables -X

USEDNS=$(cat /etc/ssh/sshd_config  | grep UseDNS | awk '{print $2}')
if [ $USEDNS != no ] ; then
   sed -i  s/"#UseDNS yes"/"UseDNS no"/ /etc/ssh/sshd_config
fi

swapoff -a

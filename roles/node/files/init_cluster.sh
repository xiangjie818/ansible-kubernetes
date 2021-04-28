#!/bin/bash
host_ip=$(hostname -i)
kubectl_config="/root/.kube/config"
kube_proxy_config="/opt/kubernetes/cfg/kube-proxy.kubeconfig"
kube_bootstrap_config="/opt/kubernetes/cfg/bootstrap.kubeconfig"
kubelet_config="/opt/kubernetes/cfg/kubelet.kubeconfig"

sed -i "s@server: https://.*@server: https://${host_ip}:6443@" $kubectl_config
sed -i "s@server: https://.*@server: https://${host_ip}:6443@" $kube_proxy_config
sed -i "s@server: https://.*@server: https://${host_ip}:6443@" $kube_bootstrap_config
sed -i "s@server: https://.*@server: https://${host_ip}:6443@" $kubelet_config

systemctl restart kubelet
systemctl restart kube-proxy

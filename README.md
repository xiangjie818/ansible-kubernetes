#### 安装准备

##### 1）修改/etc/hosts文件

```
$ vim /etc/hosts
1.0.1.1   pkgs.zxj.com
1.0.1.11  node1.zxj.com  node1
1.0.1.12  node2.zxj.com  node2
1.0.1.13  node3.zxj.com  node3
```

##### 2）修改ansible-kubernetes项目下的hosts文件，指定各节点安装内容

```
$ vim hosts
[deploy]
1.0.1.11

[chronys]
1.0.1.11 role=server
1.0.1.12 role=client
1.0.1.13 role=client

[dockers]
1.0.1.11
1.0.1.12
1.0.1.13

[etcds]
1.0.1.11
1.0.1.12
1.0.1.13

[masters]
1.0.1.11 role=master hostname=node1.zxj.com
1.0.1.12 role=node   hostname=node2.zxj.com
1.0.1.13 role=node   hostname=node3.zxj.com

[nodes]
1.0.1.11
1.0.1.12
1.0.1.13

[all:vars]
ansible_ssh_user=root
ansible_ssh_pass=123456
```

##### 3）根据集群状况修改group_vars/all.yml中的变量
```
$ vim group_vars/all.yml
---
images_repo: registry.cn-beijing.aliyuncs.com
images_namespace: zhaoxiangjie
kube_apiserver: https://1.0.1.11:6443
kube_apiserver_port: 8080
pkgs_site: http://pkgs.zxj.com
pkgs_url: /kubernetes/linux-amd64
docker_pkgs: docker-19.03.9.tar.gz
etcd_pkgs: etcd-v3.4.7-linux-amd64.tar.gz
k8s_version: 1.18.2
k8s_pkgs: kubernetes-server-linux-amd64.tar.gz
cluster_ip:
  - 1.0.1.11
  - 1.0.1.12
  - 1.0.1.13
etcd_servers: https://1.0.1.11:2379,https://1.0.1.12:2379,https://1.0.1.13:2379
etcd_cluster: node1.zxj.com=https://1.0.1.11:2380,node2.zxj.com=https://1.0.1.12:2380,node3.zxj.com=https://1.0.1.13:2380
cluster_dns: 10.10.0.2
cluster_domain: cluster.local
```
#### 安装步骤

##### 节点环境初始化
```
$ ansible-playbook init_environment.yaml -i hosts
```

如果需要配置时钟同步，可以执行
```
$ ansible-playbook chrony.yml -i hosts
```

##### 1）配置证书
```
$ ansible-playbook prepare.yml -i hosts
```

##### 2）安装docker
```
$ ansible-playbook docker.yml -i hosts
```

##### 3）安装etcd
```
$ ansible-playbook etcd.yml -i hosts
```

##### 4）安装master
```
$ ansible-playbook master.yml -i hosts
```

##### 5）安装node
```
$ ansible-playbook node.yml -i hosts
```

##### 6）安装网络插件
```
$ ansible-playbook network_plugin.yml -i hosts
```

##### 7）安装CoreDNS
```
$ ansible-playbook coredns.yml -i hosts
```

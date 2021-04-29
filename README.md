#### 安装准备

##### 1）修改/etc/hosts文件

```
# cat /etc/hosts
1.0.1.1   pkgs.zxj.com
1.0.1.11  node1.zxj.com  node1
1.0.1.12  node2.zxj.com  node2
1.0.1.13  node3.zxj.com  node3
```

##### 2）修改ansible-kubernetes项目下的hosts文件，指定各节点安装内容

```
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

#### 安装步骤

##### 节点环境初始化
```
ansible-playbook init_environment.yaml -i hosts
```

如果需要配置时钟同步，可以执行
```
ansible-playbook chrony.yml -i hosts
```

##### 1）配置证书
```
ansible-playbook prepare.yml -i hosts
```

##### 2）安装docker
```
ansible-playbook docker.yml -i hosts
```

##### 3）安装etcd
```
ansible-playbook etcd.yml -i hosts
```

##### 4）安装master
```
ansible-playbook master.yml -i hosts
```

##### 5）安装node
```
ansible-playbook node.yml -i hosts
```

##### 6）安装网络插件
```
ansible-playbook network_plugin.yml -i hosts
```

##### 7）安装CoreDNS
```
ansible-playbook coredns.yml -i hosts
```

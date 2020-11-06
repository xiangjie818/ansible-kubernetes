#### 安装准备

##### 1）修改/etc/hosts文件

```
# k8s
192.168.0.10  node1.hy.com
192.168.0.11  node2.hy.com
192.168.0.12  node3.hy.com

# harbor
192.168.31.191 node1.huoyin.com

# pkgs
192.168.31.82 pkgs.hy.com
```

##### 2）修改ansible-kubernetes项目下的hosts文件，指定各节点安装内容

##### 3）根据集群状况修改group_vars/all.yml中的变量

#### 安装步骤
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

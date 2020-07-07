1、修改hosts文件指定每个节点要安装的内容
2、根据集群状况修改group_vars/all.yml中的变量

##### 安装步骤
1）配置证书

```
ansible-playbook  prepare.yml -i hosts
```

2）安装docker
```
ansible-playbook  docker.yml -i hosts
```

3）安装etcd
```
ansible-playbook  etcd.yml -i hosts
```

4）安装master
```
ansible-playbook  master.yml -i hosts
```

5）安装node
```
ansible-playbook  node.yml -i hosts
```

6）安装网络插件
```
ansible-playbook network_plugin.yml -i hosts
```

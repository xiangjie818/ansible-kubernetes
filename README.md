1、修改hosts文件指定每个节点要安装的内容
2、根据集群状况修改group_vars/all.yml中的变量

# 安装步骤
1）配置证书
ansible-playbook -i prepare.yml -i hosts

2）安装docker
ansible-playbook -i docker.yml -i hosts

3）安装etcd
ansible-playbook -i etcd.yml -i hosts

4）安装master
ansible-playbook -i master.yml -i hosts

5）安装node
ansible-playbook -i node.yml -i hosts

6）安装网络插件
ansible-playbook -i network_plugin.yml -i hosts

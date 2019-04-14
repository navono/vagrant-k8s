# vagrant-k8s

使用 `Vagrant` 管理本地 `k8s` 集群。

## 环境准备

- 科学上网
- 安装 `Vagrant`

修改 `install-docker-ce.sh` 中的 `HTTP_PROXY` 中的代理设置。同时开启代理的入站请求。

## 启动集群

> vagrant up

如果需要独立执行脚本：

> vagrant provision machineName --provision-with boot

## 启动 `Master` 节点

> vagrant provision kmaster --provision-with master

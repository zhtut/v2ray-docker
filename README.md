# v2ray-docker
# docker 部署 v2ray配置，使用了v2ray+vless+tcp+xtls
## 部署步骤
### 准备一台服务器
我这里使用的是aws的ubuntu 22版本，应该linux的都可以，只不过有部分命令不太一样，换一下就行了

### 安装Docker

```shell
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo apt  install docker-compose
sudo groupadd docker
sudo usermod -aG docker ${USER}
```
然后重启当前shell即可使用

### 下载配置文件
```shell
mkdir v2ray && cd v2ray
git clone https://github.com/zhtut/v2ray-docker.git
```

### 配置信息
#### 1、配置config.json中的clients的id的值，可以从网上生成一个uuid
#### 2、配置ssl证书
把证书拷到ssl文件夹中，然后全名为
v2ray.bundle.crt
v2ray.key

### 启动v2ray
使用命令启动
```shell
docker compose up -d --build
```
启动后使用docker ps查看状态状态
<img width="1048" alt="image" src="https://user-images.githubusercontent.com/7497402/217845240-9ea3bec0-a0c5-441d-9eec-8989673f7de1.png">
staus为up多少时间，即为正常状态，如果是restarting 则程序崩溃了，在重启，需要查看日志寻找崩溃的原因，查看日志使用
```shell
docker logs v2ray
```

启动之后，在外面主机测试一下端口是否正常了
```shell
nc -vz host port
```
Connection to host port 443 [tcp/ddi-tcp-1] succeeded!
显示上面的succeeded则是正常了
windows 可以使用telnet来测试

正常之后客户端就可以配置了

### Mac系统
Mac系统可以使用v2rayU客户端，这个支持vless
配置大致如下

<img width="597" alt="image" src="https://user-images.githubusercontent.com/7497402/217846451-20e806e1-1015-4ef5-bf77-b4d651fe01db.png">

这个客户端暂时xtls不支持mux，还需要在高级里面关闭mux

<img width="460" alt="image" src="https://user-images.githubusercontent.com/7497402/217846654-e554b0b5-dbd4-4953-b93a-efac68ad5cf0.png">

配置好后，就可以启动测试了，如果有问题，可以查看日志解决

<img width="228" alt="image" src="https://user-images.githubusercontent.com/7497402/217847046-45d85eb2-78f5-4936-aec7-3a20a886ad6b.png">

如果连接不上，可能是服务器安全组未开放该端口，需要放开tcp和udp的端口

### iPhone 可以使用NapsternetV这个软件，需要使用大陆外的苹果账号从appstore下载
### windows可以使用v2rayN使用，配置方法都差不多










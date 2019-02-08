#!/bin/bash
yum update -y
yum install -y wget curl screen make
 
# 安装路径
Path="/root/"
cd $Path
 
# 安装WinRAR Linux最新版本
LinuxVersion=$(wget -qO- https://www.rarlab.com/download.htm | grep -Eoi '<a [^>]+>' | grep -Eo 'href="[^"]+"' | grep -Eo 'rarlinux-x64[^/"]+')
DownloadLink="https://www.rarlab.com/rar/$LinuxVersion"
wget "$DownloadLink"
 
# 安装WinRAR
tar -zxvf $LinuxVersion
cd rar
make
 
# 删除WinRAR安装包
cd $Path
rm -rf $LinuxVersion
 
# 下载人人影视最新版本
wget http://appdown.rrys.tv/rrshareweb_linux.rar
unrar x rrshareweb_linux.rar
tar -zxvf rrshareweb_centos7.tar.gz
cd rrshareweb
 
# 建立bash脚本
echo '
#!/bin/bash
screen -d -m -S rrshareweb /root/rrshareweb/rrshareweb' >> start.sh
chmod +x start.sh
bash start.sh
echo '人人影视Web版已经启动'
 
# 资料
echo '默认端口是3001，可以在配置文件里面修改'
PublicIP=$(curl -4 icanhazip.com)
echo "面板地址: http://$PublicIP:3001"
echo '面板密码: 123456'
echo '配置文件: /root/rrshareweb/conf/rrshare.json'

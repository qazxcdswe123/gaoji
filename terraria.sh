#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

Dependence="mono-complete unzip screen nano curl"
bit=`uname -m`
VER=$( wget -qO- https://github.com/Pryaxis/TShock/tags | grep -oE -m1 "/tag/v[^\"]*" | cut -dv -f2 )

if [[ -f /etc/redhat-release ]]; then
	release="centos"
elif cat /etc/issue | grep -q -E -i "debian"; then
	release="debian"
elif cat /etc/issue | grep -q -E -i "ubuntu"; then
	release="ubuntu"
elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
	release="centos"
elif cat /proc/version | grep -q -E -i "debian"; then
	release="debian"
elif cat /proc/version | grep -q -E -i "ubuntu"; then
	release="ubuntu"
elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
	release="centos"
fi

if [[ ${release} == "centos" ]]; then
    yum update && yum install $Dependence -y
else
    apt-get update && apt-get install $Dependence -y
fi

check_root() {
	[[ "$(id -u)" != "0" ]] && echo -e "请用root账号登录!" && exit 1
}

wget -O tshock.zip https://github.com/Pryaxis/TShock/releases/download/${VER}/tshock_${VER}.zip
unzip tshock.zip -d ~/tshock

echo -e "==================================="
echo -e "将在screen中运行Tshock"
echo -e "地图文件在 ~/.local/share/Terraria"
echo -e "==================================="

sleep 3s
cd tshock && screen mono TerrariaServer.exe
exit 1
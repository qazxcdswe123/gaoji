#!/bin/bash

check_root() {
	[[ "$(id -u)" != "0" ]] && echo -e "请用root账号登录!" && exit 1
}

Dependence="sudo screen unzip curl libelf-dev wget"
bit=`uname -m`

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

wget -N --no-check-certificate https://raw.githubusercontent.com/qazxcdswe123/gaoji/master/gaoji.sh && chmod +x gaoji.sh && mv gaoji.sh /usr/bin/gaoji && gaoji

exit
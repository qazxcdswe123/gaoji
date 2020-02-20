#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

Dependence="libunwind8 libunwind8-dev gettext libicu-dev liblttng-ust-dev libcurl4-openssl-dev libssl-dev uuid-dev unzip screen libkrb5-3"

check_sys(){
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
	bit=`uname -m`
}
System_structure(){
    if [[ $(bit) == "x86_64" ]]; then
        target="x64"
    elif [[$(bit) == "arm-rbpi" ]]; then
        target="arm"
    else
        echo -e "ASF不支持除x64和arm架构以外的系统，请重装系统吧"
    exit 1
    fi
}
Install_Dependence(){
    if [[ $(release) == "centos" ]]; then
        yum update && yum remove libssl1.0.0 && yum install $Dependence -y
    else
        apt-get update && apt-get purge libssl1.0.0 && apt-get install $Dependence -y
    fi
}
Get_ASF(){
    VER=$( wget -qO- https://github.com/JustArchiNET/ArchiSteamFarm/tags | grep -oE -m1 "/tag/v[^\"]*" | cut -dv -f2 )
    wget https://github.com/JustArchi/ArchiSteamFarm/releases/download/$VER/ASF-linux-$target.zip
    unzip ASF-linux-x64.zip -d ASF/
    cd ASF/ 
    chmod +x ArchiSteamFarm
    echo -e "请用ftp工具将配置文件（json/2FA）上传"
    echo -e "滚完屏后再退出，退出请输入 ctrl+c"
    ./ArchiSteamFarm
}
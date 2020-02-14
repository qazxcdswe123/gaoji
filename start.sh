#!/bin/bash
check_root() {
	[[ "$(id -u)" != "0" ]] && echo -e "请用root账号登录!" && exit 1
}
apt update
apt install sudo screen unzip curl libelf-dev -y
wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh
wget -N --no-check-certificate https://raw.githubusercontent.com/qazxcdswe123/gaoji/master/gaoji.sh && chmod +x gaoji.sh && mv gaoji.sh /usr/bin/gaoji && gaoji

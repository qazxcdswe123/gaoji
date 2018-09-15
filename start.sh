#!/bin/bash
apt update
apt install sudo screen unzip -y
apt install curl libelf-dev -y
wget https://github.com/tcp-nanqinlang/general/releases/download/3.4.5.1/tcp_nanqinlang-pro-3.4.5.1-nocheckvirt.sh
wget -N --no-check-certificate https://raw.githubusercontent.com/qazxcdswe123/gaoji/master/gaoji.sh&&chmod +x gaoji.sh&&bash gaoji.sh

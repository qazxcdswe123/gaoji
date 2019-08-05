#!/bin/bash
apt update
apt install sudo screen unzip -y
apt install curl libelf-dev -y
wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh
wget -N --no-check-certificate https://raw.githubusercontent.com/qazxcdswe123/gaoji/master/gaoji.sh && chmod +x gaoji.sh&&bash gaoji.sh

#!/bin/bash
apt update
apt install sudo screen curl unzip -y
wget https://github.com/nanqinlang-tcp/tcp_nanqinlang/releases/download/3.4.2/tcp_nanqinlang-pro-3.4.2.sh
wget -N --no-check-certificate https://raw.githubusercontent.com/qazxcdswe123/gaoji/master/gaoji.sh&&chmod +x gaoji.sh&&bash gaoji.sh

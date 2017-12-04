#!/bin/bash
#选择
echo "1:ssr
2:bbr"
read shuru #输入
if [[ $shuru=1 ]]; then
  wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ssr.sh && chmod +x ssr.sh && bash ssr.sh
elif [[ $shuru=2 ]]; then
  wget -N --no-check-certificate https://github.com/nanqinlang-tcp/tcp_nanqinlang/releases/download/3.1/tcp_nanqinlang_3.1.sh&&chmod +x tcp_nanqinlang_3.1.sh&&bash tcp_nanqinlang_3.1.sh
fi

#!/bin/bash
#选择
echo "1:ssr
2:bbr"
read -p "请选择（输入数字序号）：" shuru #输入
if [ "$shuru" == "" ]; then
  echo "未选择序号，脚本退出"
  exit 1
if [[ "$shuru"=="1" ]]; then
  wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ssr.sh && chmod +x ssr.sh && bash ssr.sh
<<<<<<< HEAD
elif [[ "$shuru"=="2" ]]; then
=======
elif [[ $shuru=2 ]]; then
>>>>>>> 1bc77aa9e58999bb7231fc898cefd688ff16a719
  wget -N --no-check-certificate https://github.com/nanqinlang-tcp/tcp_nanqinlang/releases/download/3.1/tcp_nanqinlang_3.1.sh&&chmod +x tcp_nanqinlang_3.1.sh&&bash tcp_nanqinlang_3.1.sh
fi

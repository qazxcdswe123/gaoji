#!/bin/bash
#选择
echo "1:ssr
2:bbr"
read -p "请选择（输入数字序号）：" shuru #输入
if [ "$shuru" == "" ]; then
  echo "未选择序号，脚本退出"
  exit 1
elif [[ "$shuru"=="1" ]]; then
  "need"=="1"
elif [[ "$shuru"=="2" ]]; then
  "need"=="2"
fi
if [[ "need"=="1" ]]; then
  wget -N --no-check-certificate https://softs.fun/Bash/ssr.sh && chmod +x ssr.sh && bash ssr.sh
elif [[ "need"="2" ]]; then
  wget -N --no-check-certificate https://github.com/nanqinlang-tcp/tcp_nanqinlang/releases/download/3.1/tcp_nanqinlang_3.1.sh&&bash tcp_nanqinlang_3.1.sh tcp_nanqinlang_3.1.sh
fi

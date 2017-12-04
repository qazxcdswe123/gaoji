#!/bin/bash
#选择
echo "1:ssr
2:bbr"
read shuru #输入
if [[ $shuru=1 ]]; then
  wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ssr.sh && chmod +x ssr.sh && bash ssr.sh
fi

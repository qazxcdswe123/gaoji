#!/bin/bash
Font_color_suffix="\033[0m"
Green_font_prefix="\033[32m"
rm -rf /root/gost

METHOD="-L=mws://:80 -L=tun://AEAD_CHACHA20_POLY1305:password@:8443?net=192.168.123.1/24&tcp=true"
METHOD=${METHOD}
VER="$(wget -qO- https://github.com/ginuerzh/gost/tags | grep -oE "/tag/v[^"]*" | head -n1 | cut -dv -f2)"
VER=${VER:=2.9.1}
URL="https://github.com/ginuerzh/gost/releases/download/v${VER}/gost-linux-amd64-${VER}.gz"

echo "1. Downloading gost-linux-amd64-${VER}.gz to /root/gost from $URL" && echo
[[ -f "/root/gost" ]] && rm -rf /root/gost
wget -O - $URL | gzip -d > /root/gost && chmod +x /root/gost

echo "2. Generate /etc/systemd/system/gost.service"
cat <<EOF > /etc/systemd/system/gost.service
[Unit]
Description=gost
[Service]
ExecStart=/root/gost $METHOD
Restart=always
User=root
[Install]
WantedBy=multi-user.target
EOF

systemctl enable gost.service && systemctl daemon-reload && systemctl restart gost.service && systemctl status gost -l

echo && echo -e "gost运行参数为 ${Green_font_prefix}${METHOD}${Font_color_suffix}"
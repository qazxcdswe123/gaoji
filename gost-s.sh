#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

Font_color_suffix="\033[0m"
Green_font_prefix="\033[32m"

METHOD="-L=mws://:80 -L=socks5+h2://:8443"
METHOD=${METHOD}

if [[ $(uname -m) == "x86_64" ]]; then
    bit="amd64"
elif [[ $(uname -m) == "arm-rbpi" ]]; then
    bit="armv7"
else
    bit="386"
fi

VER=$( wget -qO- https://github.com/ginuerzh/gost/tags | grep -oE -m1 "/tag/v[^\"]*" | cut -dv -f2 )
URL="https://github.com/ginuerzh/gost/releases/download/v${VER}/gost-linux-${bit}-${VER}.gz"

echo "1. Downloading gost-linux-${bit}-${VER}.gz to /root/gost from $URL" && echo
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
StandardOutput=null
StandardError=journal
LogLevelMax=warning
[Install]
WantedBy=multi-user.target
EOF

systemctl enable gost.service && systemctl daemon-reload && systemctl restart gost.service && systemctl status gost -l

echo && echo -e "gost运行参数为 ${Green_font_prefix}${METHOD}${Font_color_suffix}"
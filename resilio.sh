#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

Font_color_suffix="\033[0m"
Green_font_prefix="\033[32m"
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

if [[ $(uname -m) == "x86_64" ]]; then
    bit="x64"
elif [[ $(uname -m) == "arm-rbpi" ]]; then
    bit="armhf"
else
    bit="i386"
fi

YOUR_IP=$(curl ip.sb)
URL="https://download-cdn.resilio.com/stable/linux-${bit}/resilio-sync_${bit}.tar.gz"

echo "1. Downloading sync-linux-${bit} from $URL"
rm -rf /root/rslsync
wget -O sync.tar.gz  $URL
tar -xzf sync.tar.gz  && chmod +x /root/rslsync

echo "2. Generate /etc/systemd/system/rslsync.service"
cat <<EOF > /etc/systemd/system/rslsync.service
[Unit]
Description=rslsync
[Service]
ExecStart=/root/rslsync --webui.listen 0.0.0.0:2077
Restart=always
User=root
[Install]
WantedBy=multi-user.target
EOF

systemctl enable rslsync.service && systemctl daemon-reload && systemctl restart rslsync.service && systemctl status rslsync -l

echo && echo -e "Check ${Green_font_prefix}${YOUR_IP}:2077${Font_color_suffix}"
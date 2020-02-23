#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

if [[ $(uname -m) == "x86_64" ]]; then
    bit="amd64"
else
    bit="386"
fi

VER=$( wget -qO- https://github.com/syncthing/relaysrv/tags | grep -oE -m1 "/tag/v[^\"]*" | cut -dv -f2 )

check_root(){
	[[ $EUID != 0 ]] && echo -e "${Error} 当前非ROOT账号(或没有ROOT权限)，无法继续操作，请更换ROOT账号或使用 ${Green_background_prefix}sudo su${Font_color_suffix} 命令获取临时ROOT权限（执行后可能会提示输入当前账号的密码）。" && exit 1
}

echo -e "Downloading relaysrv ${bit}-v${VER}"

wget https://github.com/syncthing/relaysrv/releases/download/v${VER}/strelaysrv-linux-${bit}-v${VER}.tar.gz
tar xzf strelaysrv-linux-${bit}-v${VER}.tar.gz
mv strelaysrv-linux-${bit}-v${VER}/strelaysrv /usr/bin/relaysrv
rm -rf strelaysrv-linux-${bit}-v${VER} strelaysrv-linux-${bit}-v${VER}.tar.gz
useradd relaysrv -s /bin/false
mkdir /etc/relaysrv
chown relaysrv /etc/relaysrv

cat <<EOF > /etc/systemd/system/relaysrv.service
[Unit] 
Description=Syncthing relay server
[Service]
ExecStart=/usr/bin/relaysrv -keys /etc/relaysrv -provided-by="gaoji.fun-onekey-install"
Restart=always
user=relaysrv
[Install]
WantedBy=multi-user.target
EOF

systemctl enable relaysrv.service && systemctl daemon-reload && systemctl restart relaysrv.service && systemctl status relaysrv -l
echo && echo -e "Use command \"systemctl status relaysrv\" for more information" 
echo && echo -e "Go relays.syncthing.net to see if it works"
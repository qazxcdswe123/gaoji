#!/bin/bash
Font_color_suffix="\033[0m"
Green_font_prefix="\033[32m"
File="/root/gost"
sh_ver="1.0.0"
name="$local_port_to_$remote_address:$remote_port"

Download_gost() {
    if [[ $(uname -m) == "x86_64" ]]; then
        bit="amd64"
    elif [[$(uname -m) == "arm-rbpi" ]]; then
        bit="armv7"
    else
        bit="386"
    fi

    VER=$( wget -qO- https://github.com/ginuerzh/gost/tags | grep -oE -m1 "/tag/v[^\"]*" | cut -dv -f2 )
    URL="https://github.com/ginuerzh/gost/releases/download/v${VER}/gost-linux-${bit}-${VER}.gz"

    echo "1. Downloading gost-linux-${bit}-${VER}.gz to /root/gost from $URL" && echo
    [[ -f "/root/gost" ]] && rm -rf /root/gost
    wget -O - $URL | gzip -d > /root/gost && chmod +x /root/gost
}

Add_relay(){
    clear && read  -e -p "请输入本地端口: " local_port
    read  -e -p "请输入远程端口: " remote_port
    read  -e -p "请输入转发地址（支持域名ddns）: " remote_address
    echo "转发信息无误？(y/n)"
    read -e -p "本地:$local_port --> $remote_address:$remote_port" yn
    [[ -z "${yn}" ]] && yn="y"
	if [[ $yn == [Yy] ]]; then

    cat <<EOF > /etc/systemd/system/$local_port.service
    [Unit]
    Description=forward_$name

    [Service]
    RuntimeMaxSec=86400
    ExecStart=/root/gost -L=tcp://:$local_port/$remote_address:remote_port -L=udp://:$local_port/$remote_address:remote_port 
    Restart=always
    User=root
    LogLevelMax=warning

    [Install]
    WantedBy=multi-user.target
EOF

else
    exit 1
fi
}

Show_relay(){
    clear && read -e -p "请输入本地端口: " port
    systemctl status $port
}

Remove_relay(){
    clear && read -e -p "请输入本地端口: " port
    systemctl stop $port && rm /etc/systemd/system/$port.service
    echo "已删除本地$port端口的转发"
}

<<<<<<< HEAD:gost-forwad.sh
echo && echo -e "  gost一键转发脚本
0. 下载/更新gost
 --- gaoji.fun ---
1. 增加转发
2. 列出本地端口
3. 删除转发
————————————" && echo
	echo
	read -e -p " 请输入数字 [0-3]:" num
	case "$num" in
		0)
		Download_gost
		;;
		1)
		Add_relay
		;;
		2)
		Show_relay
		;;
		3)
		Remove_relay
		;;
		*)
		echo "请输入正确数字 [0-3]"
		;;
	esac
=======
>>>>>>> 7e496ec0edd1f994a484ab16055f855620fbeb35:gost-c.sh

#!/bin/bash
Font_color_suffix="\033[0m"
Green_font_prefix="\033[32m"
File="/root/gost"

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

    echo "${Green_font_prefix}1. Downloading gost-linux-${bit}-${VER} to /root/gost${Font_color_suffix}" && echo
    [[ -f "/root/gost" ]] && rm -rf /root/gost
    wget -O - $URL | gzip -d > /root/gost && chmod +x /root/gost
}

Add_relay(){
    clear && read  -e -p "请输入本地端口: " local_port
    read  -e -p "请输入远程端口: " remote_port
    read  -e -p "请输入转发地址（支持域名ddns）: " remote_address
    echo "本地:$local_port --> $remote_address:$remote_port"
    read -e -p "转发信息无误？(y/n)" yn
    [[ -z "${yn}" ]] && yn="y"
	if [[ $yn == [Yy] ]]; then

    cat <<EOF > /etc/systemd/system/port$local_port.service
    [Unit]
    Description=forward_$local_port-$remote_address:$remote_port

    [Service]
    RuntimeMaxSec=86400
    ExecStart=/root/gost -L=tcp://:$local_port/$remote_address:$remote_port -L=udp://:$local_port/$remote_address:$remote_port 
    Restart=always
    User=root
    LogLevelMax=warning

    [Install]
    WantedBy=multi-user.target
EOF
systemctl enable port$local_port.service && systemctl daemon-reload && systemctl restart port$local_port.service && systemctl status port$local_port -l

else
    exit 1
fi
}

Show_relay(){
    systemctl list-unit-files --type=service | grep -E "port[0-9]"
}

Show_status(){
    clear && read -e -p "请输入本地端口: " port
    systemctl status port$port
}

Remove_relay(){
    clear && read -e -p "请输入本地端口: " port
    systemctl stop port$port && rm /etc/systemd/system/port$port.service
    echo "已删除本地$port端口的转发"
}

echo && echo -e "  gost一键端口转发脚本
 ----- ${Green_font_prefix} gaoji.fun ${Font_color_suffix} -----
${Green_font_prefix} 1. 增加转发 ${Font_color_suffix}
${Green_font_prefix} 2. 列出本地已转发端口 ${Font_color_suffix}
${Green_font_prefix} 3. 查看端口转发状态 ${Font_color_suffix}
${Green_font_prefix} 4. 删除转发 ${Font_color_suffix}
————————————" && echo
if [[ ! -e ${File} ]]; then
    echo "下载gost中，请稍等......" && Download_gost && bash gost-c.sh
else
	echo
	read -e -p " 请输入数字 [1-4]:" num
	case "$num" in
		1)
		Add_relay
		;;
		2)
		Show_relay
		;;
		3)
		Show_status
		;;
        4)
        Remove_relay
        ;;
		*)
		echo "请输入正确数字 [1-4]"
		;;
	esac
fi
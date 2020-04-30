#!/bin/bash
Font_color_suffix="\033[0m"
Green_font_prefix="\033[32m"
File="/root/gost"
sh_ver="1.0.0"

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

Update_Shell(){
	sh_new_ver=$(wget --no-check-certificate -qO- -t1 -T3 "https://raw.githubusercontent.com/qazxcdswe123/gaoji/master/gost-c.sh"|grep 'sh_ver="'|awk -F "=" '{print $NF}'|sed 's/\"//g'|head -1)
	[[ -z ${sh_new_ver} ]] && echo -e "${Error} 无法链接到 Github !" && exit 0
	wget -N --no-check-certificate "https://raw.githubusercontent.com/qazxcdswe123/gaoji/master/gost-c.sh" && chmod +x gost-c.sh
	echo -e "脚本已更新为最新版本[ ${sh_new_ver} ] !(注意：因为更新方式为直接覆盖当前运行的脚本，所以可能下面会提示一些报错，无视即可)" && exit 0
}

Add_relay(){
    clear && read  -e -p "请输入本地端口: " local_port
    read  -e -p "请输入远程端口: " remote_port
    read  -e -p "请输入转发地址（支持域名ddns）: " remote_address
    echo "转发信息无误？(y/n)"
    read -e -p "本地:$local_port --> $remote_address:$remote_port" yn
    [[ -z "${yn}" ]] && yn="y"
	if [[ $yn == [Yy] ]]; then
    
cat <<EOF > /etc/systemd/system/$local_port_to_$remote_address:$remote_port.service
[Unit]
Description=forward_$local_port_to_$remote_address:$remote_port

[Service]
RuntimeMaxSec=86400
ExecStart=/root/gost -L=tcp://:$local_port/$remote_address:remote_port -L=udp://:$local_port/$remote_address:remote_port 
Restart=always
User=root
StandardOutput=null
StandardError=journal
LogLevelMax=warning

[Install]
WantedBy=multi-user.target
EOF
    else
        exit 1
    fi
}

}
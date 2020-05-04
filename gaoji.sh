#!/bin/bash

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"

check_root() {
	[[ "$(id -u)" != "0" ]] && echo -e "请用root账号登录!" && exit 1
}

echo && echo -e "  你要做什么？
	
 ${Green_font_prefix}1.${Font_color_suffix} 安装 SS（233boy)
 ${Green_font_prefix}2.${Font_color_suffix} 安装 BBR（teddysun）
 ${Green_font_prefix}3.${Font_color_suffix} 安装 fail2ban（修改ssh）
 ${Green_font_prefix}4.${Font_color_suffix} 安装 LNMP (网站)
 ${Green_font_prefix}5.${Font_color_suffix} 安装 ASF挂卡(steam)
 ${Green_font_prefix}6.${Font_color_suffix} 安装adbyby（广告过滤） 
 ${Green_font_prefix}7.${Font_color_suffix} 安装宝塔面板
 ${Green_font_prefix}8.${Font_color_suffix} 安装V2ray(233boy)
 ${Green_font_prefix}9.${Font_color_suffix} 安装gclone(完全同rclone)
 ${Green_font_prefix}10.${Font_color_suffix} 安装aria2
 ${Green_font_prefix}11.${Font_color_suffix} 安装Syncthing Relay服务端贡献流量
 ${Green_font_prefix}12.${Font_color_suffix} 一键封禁 垃圾邮件(SMAP)/BT/PT
 ${Green_font_prefix}13.${Font_color_suffix} 下载Speedtest-cli测速
 ${Green_font_prefix}14.${Font_color_suffix} 下载gost并按预设参数运行
 ${Green_font_prefix}15.${Font_color_suffix} 下载gost转发管理脚本
 ${Green_font_prefix}16.${Font_color_suffix} 安装Resilio Sync

先使用${Green_font_prefix} screen ${Font_color_suffix}!!!" && echo
echo -e "${Green_font_prefix} [安装前 请注意] ${Font_color_suffix}
1. 若换内核时长时间卡住请Ctrl+c或者重装系统
2. Debian 更换内核过程中会提示 [ 是否终止卸载内核 ] ，请选择 ${Green_font_prefix} NO ${Font_color_suffix}
3. 安装BBR并重启服务器后，需要重新运行脚本 启动BBR" && echo
stty erase '^H' && read -p "(默认: 取消):" need
[[ -z "${need}" ]] && echo "已取消..." && exit 1
if [[ ${need} == "1" ]]; then
	bash <(curl -s -L https://git.io/ss.sh)
elif [[ ${need} == "2" ]]; then
	bash bbr.sh || wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh
elif [[ ${need} == "3" ]]; then
	wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/Fail2ban/master/fail2ban.sh && bash fail2ban.sh 2>&1 | tee fail2ban.log
elif [[ ${need} == "4" ]]; then
	wget http://soft.vpser.net/lnmp/lnmp1.7beta.tar.gz -cO lnmp1.7beta.tar.gz && tar zxf lnmp1.7beta.tar.gz && cd lnmp1.7 && ./install.sh lnmp
elif [[ ${need} == "5" ]]; then
	wget http://raw.githubusercontent.com/qazxcdswe123/gaoji/master/asf.sh && chmod +x asf.sh && bash asf.sh
elif [[ ${need} == "6" ]]; then
	bash adbyby.sh || wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/adbyby.sh && chmod +x adbyby.sh && bash adbyby.sh
elif [[ ${need} == "7" ]]; then
	curl -sSO http://download.bt.cn/install/install_panel.sh && bash install_panel.sh
elif [[ ${need} == "8" ]]; then
	bash <(curl -s -L https://git.io/v2ray.sh)
elif [[ ${need} == "9" ]]; then
	bash <(wget -qO- https://git.io/gclone.sh)
elif [[ ${need} == "10" ]]; then
	bash aria2.sh || wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/aria2.sh && chmod +x aria2.sh && bash aria2.sh
elif [[ ${need} == "11" ]]; then
	curl https://raw.githubusercontent.com/qazxcdswe123/gaoji/master/relay.sh | bash
elif [[ ${need} == "12" ]]; then
	bash ban_iptables.sh || wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ban_iptables.sh && chmod +x ban_iptables.sh && bash ban_iptables.sh
elif [[ ${need} == "13" ]]; then
	./speedtest-cli || wget -O speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py && chmod +x speedtest-cli && ./speedtest-cli
elif [[ ${need} == "14" ]]; then
	curl https://raw.githubusercontent.com/qazxcdswe123/gaoji/master/gost-s.sh | bash
elif [[ ${need} == "15" ]]; then
	wget -N --no-check-certificate https://raw.githubusercontent.com/qazxcdswe123/gaoji/master/gost-c.sh && chmod +x gost-c.sh && bash gost-c.sh
elif [[ ${need} == "16" ]]; then
	curl https://raw.githubusercontent.com/qazxcdswe123/gaoji/master/resilio.sh | bash
else
	echo -e "请输入正确的数字(1-16)" && exit 1
fi

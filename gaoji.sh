#!/bin/bash
#选择
	echo && echo -e "  你要做什么？
	
 ${Green_font_prefix}1.${Font_color_suffix} 安装 SSR
 ${Green_font_prefix}2.${Font_color_suffix} 安装 BBR
 ${Green_font_prefix}3.${Font_color_suffix} 安装 fail2ban
 ${Green_font_prefix}4.${Font_color_suffix} 安装 lnmp" && echo
echo -e "${Green_font_prefix} [安装前 请注意] ${Font_color_suffix}
1. 用putty装||||先在ssr脚本装无改版
2. 本脚本仅支持 Debian / Ubuntu 系统更换内核，OpenVZ和Docker 不支持更换内核
3. Debian 更换内核过程中会提示 [ 是否终止卸载内核 ] ，请选择 ${Green_font_prefix} NO ${Font_color_suffix}
4. 安装BBR并重启服务器后，需要重新运行脚本 启动BBR" && echo
	stty erase '^H' && read -p "(默认: 取消):" need
	[[ -z "${need}" ]] && echo "已取消..." && exit 1
	if [[ ${need} == "1" ]]; then
		Install_SSR
	elif [[ ${need} == "2" ]]; then
		Install_BBR
	elif [[ ${need} == "3" ]]; then
		Install_fail2ban
	elif [[ ${need} == "4" ]]; then
		Install_lnmp
	else
		echo -e "${Error} 请输入正确的数字(1-4)" && exit 1
	fi
}
Install_SSR(){
  wget -N --no-check-certificate https://softs.fun/Bash/ssr.sh && chmod +x ssr.sh && bash ssr.sh
}
Install_BBR(){
  wget -N --no-check-certificate https://github.com/nanqinlang-tcp/tcp_nanqinlang/releases/download/3.1/tcp_nanqinlang_3.1.sh&&bash tcp_nanqinlang_3.1.sh tcp_nanqinlang_3.1.sh
}
Install_fail2ban(){
wget https://raw.githubusercontent.com/FunctionClub/Fail2ban/master/fail2ban.sh && bash fail2ban.sh 2>&1 | tee fail2ban.log
}
Install_lnmp(){
wget -c http://soft.vpser.net/lnmp/lnmp1.4-full.tar.gz && tar zxf lnmp1.4-full.tar.gz && cd lnmp1.4-full && ./install.sh lnmp

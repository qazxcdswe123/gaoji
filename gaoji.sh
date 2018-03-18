#!/bin/bash
check_root(){
	[[ "`id -u`" != "0" ]] && echo -e "${Error} 请用root账号登录!" && exit 1
}

	echo && echo -e "  你要做什么？
	
 ${Green_font_prefix}1.${Font_color_suffix} 安装 SSR（选项14可装原本bbr）
 ${Green_font_prefix}2.${Font_color_suffix} 安装 BBR(魔改)(易报错不推荐)
 ${Green_font_prefix}3.${Font_color_suffix} 安装 fail2ban（修改ssh）
 ${Green_font_prefix}4.${Font_color_suffix} 安装 lnmp (网站)
 ${Green_font_prefix}5.${Font_color_suffix} 安装 ASF挂卡(steam)
 ${Green_font_prefix}6.${Font_color_suffix} 安装adbyby（广告过滤） 
 ${Green_font_prefix}7.${Font_color_suffix} 安装宝塔面板 (debian)
 ${Green_font_prefix}8.${Font_color_suffix} 一键安装V2ray
 ${Green_font_prefix}9.${Font_color_suffix} 安装Gdrive(谷歌网盘)
 
 先使用screen!!!" && echo
echo -e "${Green_font_prefix} [安装前 请注意] ${Font_color_suffix}
1. 若换内核时长时间卡住请Ctrl+c或者重装系统
2. 本脚本仅支持 Debian / Ubuntu 系统更换内核，OpenVZ和Docker 不支持更换内核
3. Debian 更换内核过程中会提示 [ 是否终止卸载内核 ] ，请选择 ${Green_font_prefix} NO ${Font_color_suffix}
4. 安装BBR并重启服务器后，需要重新运行脚本 启动BBR
5. 全部只在${Green_font_prefix} Debian8 ${Font_color_suffix}上测试过
6. 不支持centos" && echo
	stty erase '^H' && read -p "(默认: 取消):" need
	[[ -z "${need}" ]] && echo "已取消..." && exit 1
	if [[ ${need} == "1" ]]; then
         wget -N --no-check-certificate https://softs.fun/Bash/ssr.sh && chmod +x ssr.sh && bash ssr.sh
	elif [[ ${need} == "2" ]]; then
         wget https://github.com/nanqinlang-tcp/tcp_nanqinlang/releases/download/3.1/tcp_nanqinlang_3.1.sh
         bash tcp_nanqinlang_3.1.sh
    elif [[ ${need} == "3" ]]; then
		wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/Fail2ban/master/fail2ban.sh && bash fail2ban.sh 2>&1 | tee fail2ban.log
	elif [[ ${need} == "4" ]]; then
		wget -c http://soft.vpser.net/lnmp/lnmp1.4.tar.gz && tar zxf lnmp1.4.tar.gz && cd lnmp1.4 && ./install.sh lnmp
	elif [[ ${need} == "5" ]]; then
	    wget https://raw.githubusercontent.com/qazxcdswe123/gaoji/master/asf.sh && chmod +x asf.sh && bash asf.sh
	elif [[ ${need} == "6" ]]; then
		wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/adbyby.sh && chmod +x adbyby.sh && bash adbyby.sh
	elif [[ ${need} == "7"  ]]; then
		wget -O install.sh http://download.bt.cn/install/install-ubuntu.sh && bash install.sh
	elif [[ ${need} == "8"  ]]; then
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/tracyone/v2ray.fun/master/install.sh)"
	elif [[ ${need} == "9"  ]]; then
		wget -O /usr/bin/gdrive "https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download"
		chmod +x /usr/bin/gdrive
	else
		echo -e "${Error} 请输入正确的数字(1-8)" && exit 1
	fi

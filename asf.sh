echo -e"只在debian8下测试过，理论上Ubuntu/Debian均可"
echo -e"默认: 取消"
stty erase '^H' && read -p "(按1安装):" need
if [[ ${need} == "1" ]]; then
	wget https://github.com/JustArchi/ArchiSteamFarm/releases/download/3.0.4.3/ASF-linux-x64.zip
	apt-get install libunwind8 libunwind8-dev gettext libicu-dev liblttng-ust-dev libcurl4-openssl-dev libssl-dev uuid-dev unzip screen -y
	unzip ASF-linux-x64.zip -d ASF/
	cd ASF/ 
	chmod +x ArchiSteamFarm
	echo -e "请用ftp工具将配置文件（json/2FA）上传"
	echo -e "退出请输入
	ctrl+c"
	echo -e "若出现奇怪的错误请按ctrl+c后输入
	./ArchiSteamFarm"
else
	exit()
fi
	
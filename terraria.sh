#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

Dependence="mono-complete unzip screen nano curl"
bit=`uname -m`
VER=$( wget -qO- https://github.com/Pryaxis/TShock/tags | grep -oE -m1 "/tag/v[^\"]*" | cut -dv -f2 )

check_root() {
	[[ "$(id -u)" != "0" ]] && echo -e "请用root账号登录!" && exit 1
}

wget -O tshock.zip https://github.com/Pryaxis/TShock/releases/download/${VER}/tshock_${VER}.zip
unzip tshock.zip -d ~/tshock

echo -e "==================================="
echo -e "将在screen中运行Tshock"
echo -e "地图文件在 ~/.local/share/Terraria"
echo -e "==================================="

sleep 3s
cd tshock && screen mono TerrariaServer.exe
exit 1
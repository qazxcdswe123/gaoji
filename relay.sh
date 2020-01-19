#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

check_root(){
	[[ $EUID != 0 ]] && echo -e "${Error} 当前非ROOT账号(或没有ROOT权限)，无法继续操作，请更换ROOT账号或使用 ${Green_background_prefix}sudo su${Font_color_suffix} 命令获取临时ROOT权限（执行后可能会提示输入当前账号的密码）。" && exit 1
}

# Install relaysrv for amd64 only

wget https://github.com/syncthing/relaysrv/releases/download/v1.3.1/strelaysrv-linux-amd64-v1.3.1.tar.gz

tar xzf strelaysrv-linux-amd64-v1.3.1.tar.gz

mv strelaysrv-linux-amd64-v1.3.1/strelaysrv /usr/bin/relaysrv

rm -rf strelaysrv-linux-amd64-v1.3.1 strelaysrv-linux-amd64-v1.3.1.tar.gz

useradd relaysrv -s /bin/false

mkdir /etc/relaysrv

chown relaysrv /etc/relaysrv

wget https://bootstrap.pypa.io/get-pip.py

python get-pip.py

rm -rf get-pip.py

pip install supervisor

echo_supervisord_conf > /etc/supervisord.conf
echo "supervisord" >> /etc/rc.local

cat >>/etc/supervisord.conf<<'EOF'
[program:relaysrv]
command=relaysrv -keys /etc/relaysrv -provided-by="Hello World"
autostart=true
autorestart=true
startsecs=10
stdout_logfile=/var/log/relaysrv.log
stdout_logfile_maxbytes=1MB
stdout_logfile_backups=10
stdout_capture_maxbytes=1MB
redirect_stderr=true
user = relaysrv
EOF

supervisord
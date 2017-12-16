# gaoji
  > wget -N --no-check-certificate https://raw.githubusercontent.com/qazxcdswe123/gaoji/master/gaoji.sh&&chmod +x gaoji.sh&&bash gaoji.sh
-  一键bbr 
ssr 
fail2ban 
lnmp 
asf


#!/bin/bash
PATH="$PATH:/usr/bin/"
DISPLAY="1"
DEPTH="16"
GEOMETRY="1024x768"
OPTIONS="-depth ${DEPTH} -geometry ${GEOMETRY} :${DISPLAY}"

case "$1" in
start)
/usr/bin/vncserver ${OPTIONS}
;;

stop)
/usr/bin/vncserver -kill :${DISPLAY}
;;

restart)
$0 stop
$0 start
;;
esac
exit 0

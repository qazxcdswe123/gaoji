#!/bin/bash
Font_color_suffix="\033[0m"
Green_font_prefix="\033[32m"

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

echo && echo -e " ${Green_font_prefix}仅下载，请自行用screen运行gost${Font_color_suffix}"
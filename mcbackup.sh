#!/usr/bin/env bash

# 用git备份mc服务端存档
# 请先手动再自动
# * 1 * * * bash /home/minecraft/world/backup.sh
time=$(date "+%D %H:%M")
cd /home/minecraft/world
git commit -m "$time"
git push -u origin master
#!/bin/bash

# 判断启动方式
start() {
  if [ "$1" = "DOWNLOAD" ]; then
    if [ -n "$(ls -A /data)" ] && [ -s /data/serverconfig.xml ]; then
        echo "change the MODE to START!"
    else
        echo "STEAMAPPID:${STEAMAPPID}"
        ./steamcmd.sh +force_install_dir /data +login anonymous +app_update "${STEAMAPPID}" validate +quit
        if [ -n "$(ls -A /data)" ] && [ -s /data/serverconfig.xml ]; then
          echo "download success"
        else
          echo "download error"
        fi
    fi
  elif [ "$1" = "START" ]; then
      echo "Start server"
      cd /data && ./7DaysToDieServer.x86_64 -logfile=/data/7DaysToDieServer_Data/output_log__"$(date +%Y-%m-%d__%H-%M-%S)".txt -configfile=serverconfig.xml -quit -batchmode -nographics -dedicated
  else
     echo "please input START or DOWNLOAD"
  fi
}

main() {
  start "$1"
}

main "${MODE}"
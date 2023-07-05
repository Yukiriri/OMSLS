#!/bin/bash
#parameter: <jar> <Xmx> [Xms]

arg="-Xmx$2 "
if [[ "$3" != "" ]]; then
  arg+="-Xms$3 "
else
  arg+="-Xms$2 "
fi

if [[ "$3" == "" ]] || [[ "$3" == "$2" ]]; then
  arg+="-XX:+UseTransparentHugePages "
fi

mem_unit=${2:0-1:1}
mem_amount=${2%$mem_unit}

if [[ "${mem_unit^}" == "G" && $mem_amount -gt 12 ]] || 
   [[ "${mem_unit^}" == "M" && $mem_amount -gt 12000 ]]; then
  G1NewSizePercent=40
  G1MaxNewSizePercent=50
  G1HeapRegionSize=16M
  G1ReservePercent=15
  InitiatingHeapOccupancyPercent=20
  arg+="-XX:ReservedCodeCacheSize=1G "
else
  G1NewSizePercent=30
  G1MaxNewSizePercent=40
  G1HeapRegionSize=8M
  G1ReservePercent=20
  InitiatingHeapOccupancyPercent=15
fi

arg+="-XX:+UnlockExperimentalVMOptions "
arg+="-XX:+AlwaysPreTouch "
arg+="-XX:+DisableExplicitGC "
arg+="-XX:+PerfDisableSharedMem "
arg+="-XX:+UseG1GC "
arg+="-XX:MaxGCPauseMillis=200 "
arg+="-XX:G1NewSizePercent=$G1NewSizePercent "
arg+="-XX:G1MaxNewSizePercent=$G1MaxNewSizePercent "
arg+="-XX:G1HeapRegionSize=$G1HeapRegionSize "
arg+="-XX:G1HeapWastePercent=5 "
arg+="-XX:G1ReservePercent=$G1ReservePercent "
arg+="-XX:G1RSetUpdatingPauseTimePercent=5 "
arg+="-XX:G1MixedGCCountTarget=4 "
arg+="-XX:G1MixedGCLiveThresholdPercent=90 "
arg+="-XX:InitiatingHeapOccupancyPercent=$InitiatingHeapOccupancyPercent "
arg+="-XX:MaxTenuringThreshold=1 "
arg+="-XX:SurvivorRatio=32 "
arg+="--add-modules=jdk.incubator.vector "
arg+="-XX:MaxInlineSize=480 "

arg+="-Xlog:async "
arg+="-Xlog:gc:logs/g1gc-%t.log "
arg+="-XX:+CrashOnOutOfMemoryError "
arg+="-Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true"
arg+="-Djava.awt.headless=true "
arg+="-Dfile.encoding=utf-8 "

yggdrasil="-javaagent:../authlib-injector.jar=https://littleskin.cn/api/yggdrasil"
yggdrasil_arg="-Dauthlibinjector.noLogFile -Dauthlibinjector.disableHttpd -Dauthlibinjector.profileKey=disabled -Dauthlibinjector.usernameCheck=enabled"

java -server $arg $yggdrasil $yggdrasil_arg -jar $1 --nogui

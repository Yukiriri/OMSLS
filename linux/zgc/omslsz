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

if [[ "${mem_unit^}" == "G" && $mem_amount -gt 8 ]] || 
   [[ "${mem_unit^}" == "M" && $mem_amount -gt 8000 ]]; then
  arg+="-XX:ReservedCodeCacheSize=1G "
fi

arg+="-XX:+UnlockExperimentalVMOptions "
arg+="-XX:+AlwaysPreTouch "
arg+="-XX:+DisableExplicitGC "
arg+="-XX:+PerfDisableSharedMem "
arg+="-XX:+UseZGC "
arg+="-XX:-ZProactive "
arg+="-XX:ZCollectionInterval=15 "
arg+="-XX:ZUncommitDelay=15 "
arg+="--add-modules=jdk.incubator.vector "
arg+="-XX:MaxInlineSize=480 "

arg+="-XX:+CrashOnOutOfMemoryError "
arg+="-Xlog:async "
arg+="-Xlog:gc:logs/zgc-%t.log "
arg+="-Djava.awt.headless=true "
arg+="-Dfile.encoding=utf-8 "

java -server $arg -jar $1 nogui

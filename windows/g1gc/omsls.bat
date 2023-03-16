@echo off & chcp 65001 >nul
::parameter: <jar> <Xmx> [Xms]

set arg=-Xmx%2
if "%3" NEQ "" (
  set arg=%arg% -Xms%3
) else (
  set arg=%arg% -Xms%2
)

if "$3" == ""   set arg=%arg% -XX:+UseTransparentHugePages
if "$3" == "$2" set arg=%arg% -XX:+UseTransparentHugePages

set mem_unit=%2
set mem_amount=%mem_unit:~0,-1%
set mem_unit=%mem_unit:~-1%

set is_more_than=0
if /i "%mem_unit%" == "G" if %mem_amount% GTR 12    set is_more_than=1
if /i "%mem_unit%" == "M" if %mem_amount% GTR 12000 set is_more_than=1
if %is_more_than% == 1 (
  set G1NewSizePercent=40
  set G1MaxNewSizePercent=50
  set G1HeapRegionSize=16M
  set G1ReservePercent=15
  set InitiatingHeapOccupancyPercent=20
  set arg=%arg% -XX:ReservedCodeCacheSize=1G
) else (
  set G1NewSizePercent=30
  set G1MaxNewSizePercent=40
  set G1HeapRegionSize=8M
  set G1ReservePercent=20
  set InitiatingHeapOccupancyPercent=15
)

set arg=%arg% -XX:+UnlockExperimentalVMOptions
set arg=%arg% -XX:+AlwaysPreTouch
set arg=%arg% -XX:+DisableExplicitGC
set arg=%arg% -XX:+PerfDisableSharedMem
set arg=%arg% -XX:+UseG1GC
set arg=%arg% -XX:MaxGCPauseMillis=200
set arg=%arg% -XX:G1NewSizePercent=%G1NewSizePercent%
set arg=%arg% -XX:G1MaxNewSizePercent=%G1MaxNewSizePercent%
set arg=%arg% -XX:G1HeapRegionSize=%G1HeapRegionSize%
set arg=%arg% -XX:G1HeapWastePercent=5
set arg=%arg% -XX:G1ReservePercent=%G1ReservePercent%
set arg=%arg% -XX:G1RSetUpdatingPauseTimePercent=5
set arg=%arg% -XX:G1MixedGCCountTarget=4
set arg=%arg% -XX:G1MixedGCLiveThresholdPercent=90
set arg=%arg% -XX:InitiatingHeapOccupancyPercent=%InitiatingHeapOccupancyPercent%
set arg=%arg% -XX:MaxTenuringThreshold=1
set arg=%arg% -XX:SurvivorRatio=32
set arg=%arg% --add-modules=jdk.incubator.vector
set arg=%arg% -XX:MaxInlineSize=480

set arg=%arg% -XX:+CrashOnOutOfMemoryError
set arg=%arg% -Xlog:async
set arg=%arg% -Xlog:gc:logs/g1gc-%t.log
set arg=%arg% -Djava.awt.headless=true
set arg=%arg% -Dfile.encoding=utf-8

java -server %arg% -jar %1 nogui

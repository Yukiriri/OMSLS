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
if /i "%mem_unit%" == "G" if %mem_amount% GTR 8    set is_more_than=1
if /i "%mem_unit%" == "M" if %mem_amount% GTR 8000 set is_more_than=1
if %is_more_than% == 1 (
  set arg=%arg% -XX:ReservedCodeCacheSize=1G
)

set arg=%arg% -XX:+UnlockExperimentalVMOptions
set arg=%arg% -XX:+AlwaysPreTouch
set arg=%arg% -XX:+DisableExplicitGC
set arg=%arg% -XX:+PerfDisableSharedMem
set arg=%arg% -XX:+UseZGC
set arg=%arg% -XX:-ZProactive
set arg=%arg% -XX:ZCollectionInterval=15
set arg=%arg% -XX:ZUncommitDelay=15
set arg=%arg% --add-modules=jdk.incubator.vector
set arg=%arg% -XX:MaxInlineSize=480

set arg=%arg% -Xlog:async
set arg=%arg% -Xlog:gc:logs/zgc-%t.log
set arg=%arg% -XX:+CrashOnOutOfMemoryError
set arg=%arg% -Djava.awt.headless=true
set arg=%arg% -Dfile.encoding=utf-8

java -server %arg% -jar %1 --nogui

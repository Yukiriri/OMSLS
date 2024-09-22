@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::cmd arg: <jar> <Xmx>
::env arg: [JAVA_BIN]


if "%JAVA_BIN%" == "" (
  set JAVA_BIN=java
)

if "%JAVA_VER%" == "" (
  for /f "delims=" %%b in ('%JAVA_BIN% --version 2^>nul ^| findstr /C:"build"') do (
    for /f "delims=" %%v in ('echo %%b ^| findstr /C:"build 21"') do set JAVA_VER=21
    for /f "delims=" %%v in ('echo %%b ^| findstr /C:"build 17"') do set JAVA_VER=17
    for /f "delims=" %%v in ('echo %%b ^| findstr /C:"build 11"') do set JAVA_VER=11
  )
)
if "%JAVA_VER%" == "" set JAVA_VER=8

set JAVA_OPTS=-XX:ConcGCThreads=%NUMBER_OF_PROCESSORS% -XX:ParallelGCThreads=%NUMBER_OF_PROCESSORS%


set mem_amount=%2
set mem_unit=%mem_amount:~-1%
set mem_amount=%mem_amount:~0,-1%

if /i "%mem_unit%" == "G" set /a soft_max_heap_size=%mem_amount%*1024/4*3 >nul
if /i "%mem_unit%" == "M" set /a soft_max_heap_size=%mem_amount%/4*3 >nul
set JAVA_OPTS=%JAVA_OPTS% -XX:SoftMaxHeapSize=%soft_max_heap_size%M

if %JAVA_VER% GEQ 21 if "%OMCSL_GC_FLAGS%" == "" (
  set OMCSL_GC_FLAGS=%~dp0\flags\zgc.txt
)

if %JAVA_VER% GEQ 17 (
  set JAVA_OPTS=%JAVA_OPTS% --add-modules=jdk.incubator.vector
)

if %JAVA_VER% LEQ 17 if "%OMCSL_GC_FLAGS%" == "" (
  set OMCSL_GC_FLAGS=%~dp0\flags\g1gc.txt
  if /i "!mem_unit!" == "G" (
    if !mem_amount! GEQ 12    set OMCSL_GC_FLAGS=%~dp0\flags\g1gc.higher.txt
  )
  if /i "!mem_unit!" == "M" (
    if !mem_amount! GEQ 12000 set OMCSL_GC_FLAGS=%~dp0\flags\g1gc.higher.txt
    if !mem_amount! LSS 250 (
      echo [OMCSL][ERROR]: Xmx ^< 250M
      goto :EOF
    )
  )
)

if %JAVA_VER% EQU 8 (
  for /f %%i in (%OMCSL_GC_FLAGS% %OMCSL_YGGDRASIL_FLAGS%) do set JAVA_OPTS=!JAVA_OPTS! %%i
) else (
  if not "%OMCSL_YGGDRASIL_FLAGS%" == "" set OMCSL_YGGDRASIL_FLAGS=@!OMCSL_YGGDRASIL_FLAGS!
  set JAVA_OPTS=@%OMCSL_GC_FLAGS% !OMCSL_YGGDRASIL_FLAGS! !JAVA_OPTS!
)


if "%OMCSL_DEBUG%" == "" (
  set OMCSL_DEBUG=0
)
if %OMCSL_DEBUG% GEQ 2 (
  set JAVA_OPTS=!JAVA_OPTS! -XX:-PerfDisableSharedMem
)
if %OMCSL_DEBUG% GEQ 1 (
  echo --------------------------------------------------
  echo [OMCSL][DEBUG]: JAVA_BIN  = %JAVA_BIN%
  echo [OMCSL][DEBUG]: JAVA_VER  = %JAVA_VER%
  echo [OMCSL][DEBUG]: jar       = %1
  echo [OMCSL][DEBUG]: Xmx       = %2
  echo [OMCSL][DEBUG]: JAVA_OPTS = !JAVA_OPTS!
  echo --------------------------------------------------
  %JAVA_BIN% -Xmx%2 !JAVA_OPTS! -XX:+PrintFlagsFinal 2>nul | findstr /C:"command line"
  echo --------------------------------------------------
)
%JAVA_BIN% -Xms%2 -Xmx%2 %JAVA_OPTS% -jar %1 --nogui

@echo off & chcp 65001 >nul
::bat arg: <jar> <Xmx> [Xms]
::env arg: [custom_java_path] [preset_java_version]

if "%custom_java_path%" == "" (
  set custom_java_path=java
)
if "%preset_java_version%" == "" (
  set preset_java_version=11
)

if "%3" == "" (
  set Xms=-Xms%2
  set fixedmem_flags=-XX:+UseLargePages
  set is_fixedmem=1
) else (
  set Xms=-Xms%3
  set fixedmem_flags=
  set is_fixedmem=0
)
set mem_amount=%2
set mem_unit=%mem_amount:~-1%
set mem_amount=%mem_amount:~0,-1%

set gc_flags=%~dp0\flags\g1gc.txt
if /i "%mem_unit%" == "G" if %mem_amount% GTR 12    set gc_flags=%~dp0\flags\g1gc-gt12.txt
if /i "%mem_unit%" == "M" if %mem_amount% GTR 12000 set gc_flags=%~dp0\flags\g1gc-gt12.txt
if %NUMBER_OF_PROCESSORS% GEQ 8 (
  if %preset_java_version% GEQ 17 (
    if %is_fixedmem% == 1 set gc_flags=%~dp0\flags\zgc.txt
    if %is_fixedmem% == 0 set gc_flags=%~dp0\flags\zgc-min.txt
  )
  if %preset_java_version% GEQ 11 (
    if %is_fixedmem% == 1 set gc_flags=%~dp0\flags\sgc.txt
    if %is_fixedmem% == 0 set gc_flags=%~dp0\flags\sgc-min.txt
  )
)
set common_flags=%~dp0\flags\common.txt

if %preset_java_version% GEQ 11 (
  %custom_java_path% -Xmx%2 %Xms% @%gc_flags% %fixedmem_flags% @%common_flags% %yggdrasil_flags% -jar %1 --nogui
) else (
  setlocal enabledelayedexpansion
  set arg=
  for /f %%i in (%gc_flags% %common_flags% %yggdrasil_flags_txt%) do (set arg=!arg! %%i)
  %custom_java_path% -Xmx%2 %Xms% !arg! %fixedmem_flags% -jar %1 --nogui
  endlocal
)

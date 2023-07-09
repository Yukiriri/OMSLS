@echo off & chcp 65001 >nul
::bat arg: <jar> <Xmx> [Xms]
::env arg: [custom_java_path]

if "%custom_java_path%" == "" (
  set custom_java_path=java
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
set gc_txt=%~dp0\flags\g1gc.txt
set common_txt=%~dp0\flags\common.txt

if /i "%mem_unit%" == "G" if %mem_amount% GTR 12    set gc_txt=%~dp0\flags\g1gc.gt12.txt
if /i "%mem_unit%" == "M" if %mem_amount% GTR 12000 set gc_txt=%~dp0\flags\g1gc.gt12.txt

setlocal enabledelayedexpansion
set arg=
for /f %%i in (%gc_txt% %common_txt% %yggdrasil_txt%) do (set arg=!arg! %%i)
%custom_java_path% -Xmx%2 %Xms% !arg! %fixedmem_flags% -jar %1 --nogui
endlocal

@echo off & chcp 65001 >nul
::bat arg: <jar> <Xmx>
::env arg: [custom_java_path]

if "%custom_java_path%" == "" (
  set custom_java_path=java
)

set mem_amount=%2
set mem_unit=%mem_amount:~-1%
set mem_amount=%mem_amount:~0,-1%
set gc_txt=%~dp0\flags\g1gc.small.txt
set common_txt=%~dp0\flags\common.txt

if /i "%mem_unit%" == "G" if %mem_amount% GTR 12    set gc_txt=%~dp0\flags\g1gc.txt
if /i "%mem_unit%" == "M" if %mem_amount% GTR 12000 set gc_txt=%~dp0\flags\g1gc.txt

setlocal enabledelayedexpansion
set flags=
for /f %%i in (%gc_txt% %common_txt% %yggdrasil_txt%) do (set flags=!flags! %%i)

%custom_java_path% -Xmx%2 -Xms%2 !flags! -jar %1 --nogui

set yggdrasil_txt=
endlocal

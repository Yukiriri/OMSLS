@echo off & chcp 65001 >nul
::bat arg: <jar> <Xmx>
::env arg: [custom_java_path]

set mem_amount=%2
set mem_unit=%mem_amount:~-1%
set mem_amount=%mem_amount:~0,-1%
set gc_flags=%~dp0\flags\g1gc.small.txt

if /i "%mem_unit%" == "G" if %mem_amount% GTR 12    set gc_flags=%~dp0\flags\g1gc.txt
if /i "%mem_unit%" == "M" if %mem_amount% GTR 12000 set gc_flags=%~dp0\flags\g1gc.txt

omsls.bat %1 %2

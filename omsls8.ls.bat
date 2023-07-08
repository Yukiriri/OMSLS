@echo off & chcp 65001 >nul
::bat arg: <jar> <Xmx> [Xms]
::env arg: [custom_java_path]

set yggdrasil_txt=%~dp0\flags\yggdrasil.txt
omsls8.bat %1 %2 %3
set yggdrasil_txt=

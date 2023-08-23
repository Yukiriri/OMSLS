@echo off & chcp 65001 >nul
::bat arg: <jar> <Xmx>
::env arg: [custom_java_path]

set omsls_yggdrasil_flags=%~dp0\flags\yggdrasil.txt
omsls8.bat %1 %2

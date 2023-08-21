@echo off & chcp 65001 >nul
::bat arg: <jar> <Xmx>
::env arg: [custom_java_path]

set yggdrasil_flags=@%~dp0\flags\yggdrasil.txt
omsls11.bat %1 %2

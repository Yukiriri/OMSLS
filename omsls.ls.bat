@echo off & chcp 65001 >nul
::bat arg: <jar> <Xmx> [Xms]
::env arg: [custom_java_path] [preset_java_version]

set yggdrasil_flags_txt=%~dp0\flags\yggdrasil.txt
set yggdrasil_flags=@%yggdrasil_flags_txt%
omsls.bat %1 %2 %3
set yggdrasil_flags_txt=
set yggdrasil_flags=

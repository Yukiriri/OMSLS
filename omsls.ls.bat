@echo off & chcp 65001 >nul
::bat arg: <jar> <Xmx> [Xms]
::env arg: [custom_java_path] [preset_java_version]

set yggdrasil_flags=@%~dp0\yggdrasil.flags.txt

omsls.bat %1 %2 %3

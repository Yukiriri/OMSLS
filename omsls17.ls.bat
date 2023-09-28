@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::cmd arg: <jar> <Xmx>
::env arg: [JAVA_EXE]

set omsls_yggdrasil_flags=%~dp0\flags\yggdrasil.txt
omsls17.bat %1 %2

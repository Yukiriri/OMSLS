@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::cmd arg: <jar> <Xmx>
::env arg: [JAVA_EXE]

set OMSLS_YGGDRASIL_FLAGS=@%~dp0\flags\yggdrasil.txt
%~dp0\omsls17 %1 %2

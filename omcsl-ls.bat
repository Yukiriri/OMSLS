@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::cmd arg: <jar> <Xmx>
::env arg: [JAVA_BIN]


set OMCSL_YGGDRASIL_FLAGS=%~dp0\flags\yggdrasil.txt
%~dp0\omcsl %1 %2

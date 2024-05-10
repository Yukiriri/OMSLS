@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::cmd arg: <jar> <Xmx>
::env arg: [JAVA_EXE]

%~dp0\omsls11 %1 %2

@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::cmd arg: <jar> <Xmx>
::env arg: [JAVA_EXE]


if "%OMSLS_JAVA8%" == "" set OMSLS_JAVA8=0

%~dp0\omsls8 %1 %2

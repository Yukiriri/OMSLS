@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::cmd arg: <jar> <Xmx>
::env arg: [JAVA_EXE]

set OMSLS_OPTS=%OMSLS_OPTS%

if "%OMSLS_GC_FLAGS%" == "" (
  set OMSLS_GC_FLAGS=%~dp0\flags\zgc.txt
)

omsls17 %1 %2

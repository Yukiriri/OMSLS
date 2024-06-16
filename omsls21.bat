@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::cmd arg: <jar> <Xmx>
::env arg: [JAVA_EXE]

if "%OMSLS_GC_FLAGS%" == "" (
  set OMSLS_GC_FLAGS=%~dp0\flags\zgc.txt
)

%~dp0\omsls %1 %2

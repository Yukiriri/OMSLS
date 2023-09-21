@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::bat arg: <jar> <Xmx>
::env arg: [JAVA_EXE]

set JAVA_OPTS=%JAVA_OPTS%


if "%omsls_gc_flags%" == "" (
  set omsls_gc_flags=%~dp0\flags\zgc.txt
)

omsls17.bat %1 %2

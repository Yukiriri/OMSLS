@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::bat arg: <jar> <Xmx> [Xms]
::env arg: [custom_java_path]


set omsls_extend_common_flags=--add-modules jdk.incubator.vector %omsls_extend_common_flags%

if "%omsls_gc_flags%" == "" (
  if "%3" == "" (
    set omsls_gc_flags=%~dp0\flags\zgc.txt
  ) else (
    set omsls_gc_flags=%~dp0\flags\zgc.min.txt
  )
)

omsls11.bat %1 %2 %3

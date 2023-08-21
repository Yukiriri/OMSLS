@echo off & chcp 65001 >nul
::bat arg: <jar> <Xmx> [Xms]
::env arg: [custom_java_path]


set extend_common_flags=%extend_common_flags% --add-modules jdk.incubator.vector

if "%gc_flags%" == "" (
  if "%3" == "" (
    set gc_flags=%~dp0\flags\zgc.txt
  ) else (
    set gc_flags=%~dp0\flags\zgc.min.txt
  )
)

omsls.bat %1 %2 %3

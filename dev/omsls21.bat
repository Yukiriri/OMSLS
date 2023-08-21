@echo off & chcp 65001 >nul
::bat arg: <jar> <Xmx> [Xms]
::env arg: [custom_java_path]

set extend_common_flags=%extend_common_flags% 

if "%gc_flags%" == "" (
  if "%3" == "" (
    set gc_flags=%~dp0\flags\zgc.gen.txt
  ) else (
    set gc_flags=%~dp0\flags\zgc.gen.min.txt
  )
)

omsls17.bat %1 %2 %3

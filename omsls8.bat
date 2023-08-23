@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::bat arg: <jar> <Xmx>
::env arg: [custom_java_path]

if "%omsls_gc_flags%" == "" (
  set mem_amount=%2
  set mem_unit=!mem_amount:~-1!
  set mem_amount=!mem_amount:~0,-1!

  set omsls_gc_flags=%~dp0\flags\g1gc.small.txt
  if /i "!mem_unit!" == "G" if !mem_amount! GEQ 12    set omsls_gc_flags=%~dp0\flags\g1gc.txt
  if /i "!mem_unit!" == "M" if !mem_amount! GEQ 12000 set omsls_gc_flags=%~dp0\flags\g1gc.txt

  if "%omsls_is_legacy_java_cmd%" == "" set omsls_is_legacy_java_cmd=1
  omsls.bat %1 %2
) else (
  omsls.bat %1 %2 %3
)

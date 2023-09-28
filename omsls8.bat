@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::cmd arg: <jar> <Xmx>
::env arg: [JAVA_EXE]

set JAVA_OPTS=%JAVA_OPTS%


if "%omsls_gc_flags%" == "" (
  set mem_amount=%2
  set mem_unit=!mem_amount:~-1!
  set mem_amount=!mem_amount:~0,-1!

  set omsls_gc_flags=%~dp0\flags\g1gc.txt
  if /i "!mem_unit!" == "G" (
    if !mem_amount! GTR 12    set omsls_gc_flags=%~dp0\flags\g1gc.higher.txt
  )
  if /i "!mem_unit!" == "M" (
    if !mem_amount! GTR 12000 set omsls_gc_flags=%~dp0\flags\g1gc.higher.txt
    if !mem_amount! LSS 250 (
      echo [OMSLS][error]: 'Xmx' require 250M+
      goto :EOF
    )
  )
)

omsls %1 %2

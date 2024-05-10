@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::cmd arg: <jar> <Xmx>
::env arg: [JAVA_EXE]

set corrected_mem=%2
if "%OMSLS_GC_FLAGS%" == "" (
  set mem_amount=%2
  set mem_unit=!mem_amount:~-1!
  set mem_amount=!mem_amount:~0,-1!

  set OMSLS_GC_FLAGS=%~dp0\flags\g1gc.txt
  if /i "!mem_unit!" == "G" (
    if !mem_amount! GTR 12    set OMSLS_GC_FLAGS=%~dp0\flags\g1gc.higher.txt
  )
  if /i "!mem_unit!" == "M" (
    if !mem_amount! GTR 12000 set OMSLS_GC_FLAGS=%~dp0\flags\g1gc.higher.txt
    if !mem_amount! LSS 250 (
      set corrected_mem=250M
    )
  )
)
if "%OMSLS_JAVA8%" == "" set OMSLS_JAVA8=1

%~dp0\omsls %1 %corrected_mem%

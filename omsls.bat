@echo off & chcp 65001 >nul
::bat arg: <jar> <Xmx> [Xms]
::env arg: [custom_java_path] [preset_java_version]

if "%custom_java_path%" == "" (
  set custom_java_path=java
)
if "%preset_java_version%" == "" (
  set preset_java_version=11
)

if "%3" == "" (
  set Xms=-Xms%2
  set fixedmem_flags=-XX:+UseLargePages
) else (
  set Xms=-Xms%3
  set fixedmem_flags=
)
set mem_amount=%2
set mem_unit=%mem_amount:~-1%
set mem_amount=%mem_amount:~0,-1%

set is_high_profile=0
if %NUMBER_OF_PROCESSORS% GEQ 8 if %preset_java_version% GEQ 11 set is_high_profile=1
if %is_high_profile% == 1 (
  set gc_flags=@%~dp0\flags\sgc.txt
) else (
  set gc_flags=@%~dp0\flags\g1gc.txt
  if /i "%mem_unit%" == "G" if %mem_amount% GTR 12    set gc_flags=@%~dp0\flags\g1gc-gt12.txt
  if /i "%mem_unit%" == "M" if %mem_amount% GTR 12000 set gc_flags=@%~dp0\flags\g1gc-gt12.txt
)

%custom_java_path% -Xmx%2 %Xms% %gc_flags% %fixedmem_flags% @%~dp0\flags\common.txt %yggdrasil_flags% -jar %1 --nogui

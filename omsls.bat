@echo off & chcp 65001 >nul
::bat arg: <jar> <Xmx> [Xms]
::env arg: [custom_java_path] [preset_java_version]

if "%custom_java_path%" == "" (
  set custom_java_path=java
)
if "%preset_java_version%" == "" (
  set preset_java_version=17
)

if "%3" == "" (
  set Xms=-Xms%2
  set UseLargePages=-XX:+UseLargePages
) else (
  set Xms=-Xms%3
  set UseLargePages=
)
set mem_unit=%2
set mem_amount=%mem_unit:~0,-1%
set mem_unit=%mem_unit:~-1%

set gc_flags=
set is_high_profile=0
if %NUMBER_OF_PROCESSORS% GEQ 8 if %preset_java_version% GEQ 17 set is_high_profile=1
if %is_high_profile% == 1 (
  set gc_flags=@%~dp0\omsls-sgc.flags.txt
) else (
  set gc_flags=@%~dp0\omsls-g1gc.flags.txt
  if /i "%mem_unit%" == "G" if %mem_amount% GTR 12    set gc_flags=@%~dp0\omsls-g1gc-gt12.flags.txt
  if /i "%mem_unit%" == "M" if %mem_amount% GTR 12000 set gc_flags=@%~dp0\omsls-g1gc-gt12.flags.txt
)

%custom_java_path% -Xmx%2 %Xms% %gc_flags% %UseLargePages% @%~dp0\omsls-common.flags.txt %yggdrasil% %yggdrasil_arg% -jar %1 --nogui

rem @echo off & chcp 65001 >nul

if "%custom_java_path%" == "" (
  set custom_java_path=java
)


set extend_common_flags=%extend_common_flags% -XX:+UseVectorCmov

if "%3" == "" (
  set Xms=-Xms%2
  rem set extend_common_flags=%extend_common_flags% -XX:+UseLargePages
) else (
  set Xms=-Xms%3
)

%custom_java_path% -Xmx%2 %Xms% @%gc_flags% %extend_common_flags% @%~dp0\flags\common.txt %yggdrasil_flags% -jar %1 --nogui

set gc_flags=
set extend_common_flags=
set yggdrasil_flags=

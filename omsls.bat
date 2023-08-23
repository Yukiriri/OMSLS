rem @echo off & chcp 65001 >nul

if "%custom_java_path%" == "" (
  set custom_java_path=java
)

if "%3" == "" (
  set Xms=-Xms%2
  rem set omsls_extend_common_flags=-XX:+UseLargePages %omsls_extend_common_flags%
) else (
  set Xms=-Xms%3
)


set omsls_common_flags=%~dp0\flags\common.txt

if "%omsls_is_legacy_java_cmd%" == "0" (
  set omsls_final_flags=@%omsls_gc_flags% @%omsls_common_flags% %omsls_extend_common_flags%
  if not "%omsls_yggdrasil_flags%" == "" (
    set omsls_final_flags=!omsls_final_flags! @%omsls_yggdrasil_flags%
  )
) else (
  set omsls_final_flags=
  for /f %%i in (%omsls_gc_flags% %omsls_common_flags% %omsls_yggdrasil_flags%) do (set omsls_final_flags=!omsls_final_flags! %%i)
  set omsls_final_flags=!omsls_final_flags! %omsls_extend_common_flags%
)


set omsls_gc_flags=
set omsls_extend_common_flags=
set omsls_yggdrasil_flags=
set omsls_is_legacy_java_cmd=

%custom_java_path% -Xmx%2 %Xms% %omsls_final_flags% -jar %1 --nogui

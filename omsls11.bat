@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::bat arg: <jar> <Xmx>
::env arg: [custom_java_path]

set omsls_extend_common_flags=-XX:+UseVectorCmov %omsls_extend_common_flags%
set omsls_is_legacy_java_cmd=0

if "%omsls_gc_flags%" == "" (
  omsls8.bat %1 %2
) else (
  omsls8.bat %1 %2 %3
)

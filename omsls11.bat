@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::cmd arg: <jar> <Xmx>
::env arg: [JAVA_EXE]

set JAVA_OPTS=-XX:+UseVectorCmov %JAVA_OPTS%


omsls8 %1 %2

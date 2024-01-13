@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::cmd arg: <jar> <Xmx>
::env arg: [JAVA_EXE]

set OMSLS_OPTS=--add-modules jdk.incubator.vector %OMSLS_OPTS%

omsls11 %1 %2

@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::bat arg: <jar> <Xmx>
::env arg: [JAVA_EXE]

set JAVA_OPTS=--add-modules jdk.incubator.vector %JAVA_OPTS%


omsls11.bat %1 %2

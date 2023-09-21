
set omsls_common_flags=%~dp0\flags\common.txt
rem set JAVA_OPTS=-XX:+UseLargePages %JAVA_OPTS%

if "%JAVA_EXE%" == "" (
  set JAVA_EXE=java
)

set JAVA_OPTS=
for /f %%i in (%omsls_gc_flags% %omsls_common_flags% %omsls_yggdrasil_flags%) do (set JAVA_OPTS=!JAVA_OPTS! %%i)

rem echo JAVA_OPTS=%JAVA_OPTS%
%JAVA_EXE% -Xms%2 -Xmx%2 %JAVA_OPTS% -jar %1 --nogui

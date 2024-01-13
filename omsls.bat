

if "%JAVA_EXE%" == "" (
  set JAVA_EXE=java
)

set JAVA_OPTS=

if "%OMSLS_JAVA8%" == "1" (
  for /f %%i in (%OMSLS_GC_FLAGS% %OMSLS_YGGDRASIL_FLAGS%) do (set JAVA_OPTS=!JAVA_OPTS! %%i)
  set JAVA_OPTS=!JAVA_OPTS! %OMSLS_OPTS%
) else (
  set JAVA_OPTS=@%OMSLS_GC_FLAGS% %OMSLS_YGGDRASIL_FLAGS% !JAVA_OPTS! %OMSLS_OPTS%
)

rem echo JAVA_OPTS=%JAVA_OPTS%
%JAVA_EXE% -Xms%2 -Xmx%2 %JAVA_OPTS% -jar %1 --nogui

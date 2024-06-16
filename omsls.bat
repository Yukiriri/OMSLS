
if "%JAVA_EXE%" == "" (
  set JAVA_EXE=java
)

rem set JAVA_OPTS=-XX:+UseLargePages

if "%OMSLS_JAVA8%" == "1" (
  for /f %%i in (%OMSLS_GC_FLAGS% %OMSLS_YGGDRASIL_FLAGS%) do (set JAVA_OPTS=!JAVA_OPTS! %%i)
) else (
  set JAVA_OPTS=@%OMSLS_GC_FLAGS% %OMSLS_YGGDRASIL_FLAGS% %JAVA_OPTS%
)

if "%OMSLS_DEBUG%" == "1" (
  set JAVA_OPTS=%JAVA_OPTS% -XX:-PerfDisableSharedMem
  echo ==============================
  echo %JAVA_EXE% -Xms%2 -Xmx%2 !JAVA_OPTS! -jar %1 --nogui
  echo ==============================
)
%JAVA_EXE% -Xms%2 -Xmx%2 %JAVA_OPTS% -jar %1 --nogui

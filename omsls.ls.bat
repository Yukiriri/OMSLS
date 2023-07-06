@echo off & chcp 65001 >nul
::parameter: <jar> <Xmx> [Xms]

set yggdrasil=-javaagent:../authlib-injector.jar=https://littleskin.cn/api/yggdrasil
set yggdrasil_arg=-Dauthlibinjector.noLogFile -Dauthlibinjector.disableHttpd -Dauthlibinjector.profileKey=disabled -Dauthlibinjector.usernameCheck=enabled

omsls.bat %1 %2 %3

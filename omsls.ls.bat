@echo off & chcp 65001 >nul
::bat arg: <jar> <Xmx> [Xms]
::env arg: [custom_java_path] [preset_java_version]

set yggdrasil=-javaagent:../authlib-injector.jar=https://littleskin.cn/api/yggdrasil
set yggdrasil_arg=-Dauthlibinjector.noLogFile -Dauthlibinjector.disableHttpd -Dauthlibinjector.profileKey=disabled -Dauthlibinjector.usernameCheck=enabled

omsls.bat %1 %2 %3

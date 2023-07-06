#!/bin/bash
#bat arg: <jar> <Xmx> [Xms]
#env arg: [custom_java_path] [preset_java_version]

yggdrasil=-javaagent:../authlib-injector.jar=https://littleskin.cn/api/yggdrasil
yggdrasil_arg=-Dauthlibinjector.noLogFile -Dauthlibinjector.disableHttpd -Dauthlibinjector.profileKey=disabled -Dauthlibinjector.usernameCheck=enabled

omsls.sh $1 $2 $3

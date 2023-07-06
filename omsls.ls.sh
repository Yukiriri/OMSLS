#!/bin/bash
#parameter: <jar> <Xmx> [Xms]

yggdrasil=-javaagent:../authlib-injector.jar=https://littleskin.cn/api/yggdrasil
yggdrasil_arg=-Dauthlibinjector.noLogFile -Dauthlibinjector.disableHttpd -Dauthlibinjector.profileKey=disabled -Dauthlibinjector.usernameCheck=enabled

omsls.sh $1 $2 $3

#!/bin/bash
#cmd arg: <jar> <Xmx>
#env arg: [JAVA_BIN]

export omsls_yggdrasil_flags=$(cd $(dirname $0); pwd)/flags/yggdrasil.txt
omsls21.sh $1 $2

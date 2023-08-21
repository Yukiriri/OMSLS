#!/bin/bash
#bat arg: <jar> <Xmx>
#env arg: [custom_java_path]

export yggdrasil_txt=$(cd $(dirname $0); pwd)/flags/yggdrasil.txt
omsls8.sh $1 $2

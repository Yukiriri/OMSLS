#!/bin/bash
#bat arg: <jar> <Xmx> [Xms]
#env arg: [custom_java_path]

export yggdrasil_flags=@$(cd $(dirname $0); pwd)/flags/yggdrasil.txt
omsls17.sh $1 $2 $3

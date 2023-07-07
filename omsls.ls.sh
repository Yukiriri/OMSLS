#!/bin/bash
#bat arg: <jar> <Xmx> [Xms]
#env arg: [custom_java_path] [preset_java_version]

yggdrasil_arg=@$(cd $(dirname $0); pwd)/flags/yggdrasil.txt

omsls.sh $1 $2 $3

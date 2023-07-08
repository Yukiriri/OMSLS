#!/bin/bash
#bat arg: <jar> <Xmx> [Xms]
#env arg: [custom_java_path] [preset_java_version]

export yggdrasil_flags=$(cd $(dirname $0); pwd)/flags/yggdrasil.txt
omsls.sh $1 $2 $3
export yggdrasil_flags=

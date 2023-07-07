#!/bin/bash
#bat arg: <jar> <Xmx> [Xms]
#env arg: [custom_java_path] [preset_java_version]

export yggdrasil_flags_txt=$(cd $(dirname $0); pwd)/flags/yggdrasil.txt
export yggdrasil_flags=@$yggdrasil_flags_txt
omsls.sh $1 $2 $3
export yggdrasil_flags_txt=
export yggdrasil_flags=

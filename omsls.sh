#!/bin/bash

if [[ "$custom_java_path" == "" ]]; then
  custom_java_path=java
fi

shell_dir=$(cd $(dirname $0); pwd)
export extend_common_flags+=" -XX:+UseVectorCmov"

if [[ "$3" == "" ]]; then
  Xms=-Xms$2
  export extend_common_flags+=" -XX:+UseTransparentHugePages"
else
  Xms=-Xms$3
fi

gc_flags_bak=$gc_flags
extend_common_flags_bak=$extend_common_flags
yggdrasil_flags_bak=$yggdrasil_flags
export gc_flags=
export extend_common_flags=
export yggdrasil_flags=

$custom_java_path -Xmx$2 $Xms @$gc_flags_bak $extend_common_flags_bak @$shell_dir/flags/common.txt $yggdrasil_flags_bak -jar $1 --nogui

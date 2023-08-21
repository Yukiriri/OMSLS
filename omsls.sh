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

$custom_java_path -Xmx$2 $Xms @$gc_flags $extend_common_flags @$shell_dir/flags/common.txt $yggdrasil_flags -jar $1 --nogui

export gc_flags=
export extend_common_flags=
export yggdrasil_flags=

#!/bin/bash

shell_dir=$(cd $(dirname $0); pwd)
omsls_common_flags=$shell_dir/flags/common.txt
JAVA_OPTS+="-XX:+UseTransparentHugePages "

if [[ "$JAVA_BIN" == "" ]]; then
  JAVA_BIN=java
fi

JAVA_OPTS="$(<$omsls_gc_flags) $(<$omsls_common_flags) $JAVA_OPTS "
if [[ "$omsls_yggdrasil_flags" != "" ]]; then
  JAVA_OPTS+="$(<$omsls_yggdrasil_flags) "
fi

export omsls_gc_flags=
export omsls_yggdrasil_flags=

echo JAVA_OPTS=$JAVA_OPTS
$JAVA_BIN -Xms$2 -Xmx$2 $JAVA_OPTS -jar $1 --nogui

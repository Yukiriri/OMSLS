#!/bin/bash
#bat arg: <jar> <Xmx>
#env arg: [custom_java_path]

export omsls_extend_common_flags+="-XX:+UseVectorCmov "
export omsls_is_legacy_java_cmd=0

if [[ "$omsls_gc_flags" == "" ]]; then
  omsls8.sh $1 $2
else
  omsls8.sh $1 $2 $3
fi

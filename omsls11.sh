#!/bin/bash
#bat arg: <jar> <Xmx>
#env arg: [JAVA_BIN]

export JAVA_OPTS+="-XX:+UseVectorCmov "


omsls8.sh $1 $2

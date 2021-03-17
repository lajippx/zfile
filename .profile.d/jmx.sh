#!/bin/bash


BIN_DIR=`pwd`
DEPLOY_DIR=`pwd`
ls /app/src
CLASSES=WEB-INF/classes
MAIN=im.zhaojun.zfile.ZfileApplication
JMX_HOST_NAME=0.0.0.0
JMX_PORT=1099

BITS=`java -version 2>&1 | grep -i 64-bit`
JAVA_MEM_OPTS=" -Djava.security.egd=file:/dev/./urandom -Dfile.encoding=utf-8 "

SERVER_NAME="zfile-3.0.0"


LIB_DIR=./WEB-INF/lib
LIB_JARS=`ls $LIB_DIR|grep .jar|awk '{print "'$LIB_DIR'/"$0}'|tr "\n" ":"`

JAVA_OPTS=" -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true -Duser.timezone=GMT+08"

JAVA_DEBUG_OPTS=""
if [ "$1" = "debug" ]; then
    JAVA_DEBUG_OPTS=" -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n "
fi

OPTS=""
for key in "$@"
do
    OPTS="$OPTS $key"
done
echo "OPTS param: $OPTS"

if [ "$APM_AGENT_HOME" ]; then
    echo "APM plugin detected,auto enable APM plugin,apm path:$APM_AGENT_HOME"
    JAVA_OPTS=$JAVA_OPTS" -javaagent:$APM_AGENT_HOME/apm-agent-2.1.6-rc2.jar"
fi

JAVA_JMX_OPTS=""
if [ "$1" = "jmx" ]; then
    JAVA_JMX_OPTS=" -Djava.rmi.server.hostname=$JMX_HOST_NAME -Dcom.sun.management.jmxremote.port=$JMX_PORT -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false "
fi


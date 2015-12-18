#!/bin/bash

function startTomcat(){
    echo "Starting tomcat..."


    export CATALINA_HOME="$BASE_DIR/software/apache-tomcat"
    export CATALINA_BASE="$BASE_DIR/main/target/tomcat"
    export JAVA_OPTS="-Dspring.profiles.active=prod -Dehi.images.root=$2 -Dext.props.path=$BASE_DIR/config/$1/environment -Dlog.level=INFO -Dlog.path=$BASE_DIR/logs -Duser.timezone=America/Los_Angeles -server -Xms256m -Xmx1024m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=256m "
    export CATALINA_OUT="$BASE_DIR/logs/catalina.out"
    export CATALINA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=9999"
    export CATALINA_PID="$CATALINA_BASE/catalina.pid"
    chmod +x $CATALINA_HOME/bin/*.sh
    $CATALINA_HOME/bin/catalina.sh start
}

startTomcat
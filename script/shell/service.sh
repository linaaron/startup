#!/bin/bash
. ./shell/evn.sh

function installWar() {
    echo "Installing $1 war..."

    if [[ -z $1 ]]
    then
        mvn clean install -f $BECKEND_HOME -Dmaven.test.skip=true
    else
        mvn clean install -f $BECKEND_HOME/$1 -Dmaven.test.skip=true
    fi
}

function startTomcat() {
    echo "Starting tomcat ..."
    export CATALINA_HOME="$BASE_DIR/tomcat/one"
    export CATALINA_BASE="$BASE_DIR/tomcat/one"
    export JAVA_OPTS="-Dcatalina.home=$CATALINA_HOME -Dcatalina.base=$CATALINA_HOME  -Djava.io.tmpdir=$CATALINA_HOME\temp -ms256m -mx1024m  -XX:MaxPermSize=160m -Duser.language=en -Dfile.encoding=UTF8 -Duser.timezone=GMT -Djava.net.preferIPv4Stack=true"
    export CATALINA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=9991"
    export CATALINA_PID="$BASE_DIR/tomcat/catalina.pid"

    $CATALINA_HOME/bin/catalina.sh start
}

function stopTomcat() {
    echo "Stoping tomcat ..."
    export CATALINA_HOME="$BASE_DIR/tomcat/one"
    export CATALINA_BASE="$BASE_DIR/tomcat/one"
    export CATALINA_PID="$BASE_DIR/tomcat/catalina.pid"
    $CATALINA_HOME/bin/catalina.sh stop -force
}

function startTomcatTwo(){
    echo "Starting tomcat two..."
    export CATALINA_HOME="$BASE_DIR/software/apache-tomcat"
    export CATALINA_BASE="$BASE_DIR/main/target/tomcat"
    export JAVA_OPTS="-Dspring.profiles.active=prod -Dehi.images.root=$2 -Dext.props.path=$BASE_DIR/config/$1/environment -Dlog.level=INFO -Dlog.path=$BASE_DIR/logs -Duser.timezone=America/Los_Angeles -server -Xms256m -Xmx1024m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=256m "
    export CATALINA_OUT="$BASE_DIR/logs/catalina.out"
    export CATALINA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=9999"
    export CATALINA_PID="$CATALINA_BASE/catalina.pid"
    chmod +x $CATALINA_HOME/bin/*.sh
    $CATALINA_HOME/bin/catalina.sh start
}

#startTomcat
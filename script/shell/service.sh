#!/bin/bash
. ./script/shell/evn.sh

function installWar() {
    echo "Installing $1 war..."

    if [[ -z $1 ]]
    then
        mvn clean install -f $BECKEND_HOME -Dmaven.test.skip=true
    else
        mvn clean install -gs $MAVEN_HOME/conf/settings-self.xml -f $BECKEND_HOME/$1 -Dmaven.test.skip=true
    fi
}

function startTomcatOne() {
    echo "Starting tomcat ..."
    export CATALINA_HOME="$BASE_DIR/software/tomcat/one"
#    export CATALINA_BASE="$BASE_DIR/software/tomcat/one"
    export JAVA_OPTS="-Dcatalina.home=$CATALINA_HOME -Dcatalina.base=$CATALINA_HOME -Dspring.profiles.active=test -Dself.env=local -Djava.io.tmpdir=$CATALINA_HOME\temp -ms256m -mx1024m  -XX:MaxPermSize=160m -Duser.language=en -Dfile.encoding=UTF8 -Duser.timezone=GMT -Djava.net.preferIPv4Stack=true"
    export CATALINA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=9991"
    export CATALINA_PID="$BASE_DIR/software/tomcat/catalina.pid"

    $CATALINA_HOME/bin/catalina.sh start
}

function startTomcatTwo(){
    echo "Starting tomcat two..."
    export CATALINA_HOME="$BASE_DIR/software/tomcat/two"
#    export CATALINA_BASE="$BASE_DIR/software/tomcat/two"
    export JAVA_OPTS="-Dcatalina.home=$CATALINA_HOME -Dcatalina.base=$CATALINA_HOME  -Djava.io.tmpdir=$CATALINA_HOME\temp -ms256m -mx1024m  -XX:MaxPermSize=160m -Duser.language=en -Dfile.encoding=UTF8 -Duser.timezone=GMT -Djava.net.preferIPv4Stack=true"
    export CATALINA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=9991"
    export CATALINA_PID="$BASE_DIR/software/tomcat/catalina.pid"

    $CATALINA_HOME/bin/catalina.sh start
#    export JAVA_OPTS="-Dspring.profiles.active=prod -Dehi.images.root=$2 -Dext.props.path=$BASE_DIR/config/$1/environment -Dlog.level=INFO -Dlog.path=$BASE_DIR/logs -Duser.timezone=America/Los_Angeles -server -Xms256m -Xmx1024m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=256m "
#    export CATALINA_OUT="$BASE_DIR/logs/catalina.out"
#    export CATALINA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=9999"
#    export CATALINA_PID="$CATALINA_BASE/catalina.pid"
#    chmod +x $CATALINA_HOME/bin/*.sh
#    $CATALINA_HOME/bin/catalina.sh start
}

function stopTomcat() {
    echo "Stoping tomcat ..."
    export CATALINA_HOME="$BASE_DIR/software/tomcat/one"
#    export CATALINA_BASE="$BASE_DIR/tomcat/one"
    export CATALINA_PID="$BASE_DIR/software/tomcat/catalina.pid"
    $CATALINA_HOME/bin/catalina.sh stop -force
}

function startApache() {
    echo "Starting apache..."

    $APACHE_HOME/bin/httpd &
    echo $! > $APACHE_HOME/../httpd.pid
    echo $APACHE_HOME
}

function stopApache() {
    echo "Stopping apache..."

    kill -9 $(cat $APACHE_HOME/../httpd.pid)
}
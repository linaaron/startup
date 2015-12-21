#! /bin/bash

JENKINS_DIR=D:/tool/jenkins

echo "starting jenkins..."
java -jar $JENKINS_DIR/jenkins.war &
echo $! > $JENKINS_DIR/jenkins.pid
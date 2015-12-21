#! /bin/bash

JENKINS_DIR=D:/tool/jenkins

echo "stopping jenkins..."
kill -9 $(cat $JENKINS_DIR/jenkins.pid)

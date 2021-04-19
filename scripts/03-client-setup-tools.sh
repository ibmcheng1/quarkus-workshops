#!/bin/sh

WORKING_DIR=${PWD}

# install jdk 11
FILE=OpenJDK11U-jdk_x64_linux_hotspot_11.0.10_9.tar.gz
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else 
    echo "$FILE does not exist."
    wget get https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.10+9/$FILE
    tar -zxvf $FILE
fi

export JAVA_HOME=$WORKING_DIR/jdk-11.0.10+9   
$JAVA_HOME/bin/java -version 


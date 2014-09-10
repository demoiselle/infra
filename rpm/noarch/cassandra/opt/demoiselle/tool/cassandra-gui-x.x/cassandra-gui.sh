#!/bin/bash

CASSANDRA_GUI_HOME="/opt/demoiselle/tool/cassandra-gui-0.6/"

if [ "$1" == "-h" -o "$1" == "--help" ]
then
	echo "Usage: $0 [host] [thrift port] [jmx port]"
	echo "Default: $0 localhost 9160 8080"
	exit 1
fi

java -jar $CASSANDRA_GUI_HOME/cassandra-gui.one-jar.jar $@


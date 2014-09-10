#!/bin/bash

MB_HOME="/opt/demoiselle/tool/mongobrowser-0.1/"

if [ "$1" == "-h" -o "$1" == "--help" ]
then
	echo "Usage: $0 [server] [port]"
	echo "Default: $0 localhost 27017"
	exit 1
fi

libs=`ls $MB_HOME/*.jar | tr "\n" ":"`

java -cp $libs com.mebigfatguy.mongobrowser.MongoBrowser $@

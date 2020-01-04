#!/bin/bash
server=ftp.cluster029.hosting.ovh.net
port=21

DIR=$(dirname $0)/../_site

function usage() {
	echo "Usage:"
	echo -e "\t$0 <user> <pass>"
}

if [ $# -eq 2 ]; then
	user=$1
	pass=$2

	if [ -d $DIR ]; then
		echo "Entering $DIR"
		cd $DIR
		echo 'echo "mput *" | gftp-text ftp://${user}:${pass}@${server}:${port}/www'
	else
		echo "Directory $DIR not found. Did you compile your site?"
	fi
else
	usage
fi

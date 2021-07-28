#!/bin/bash
server=ftp.cluster029.hosting.ovh.net
port=21

WD=$(dirname $0)
ROOT_DIR=$WD/../
DIR=$WD/../_production_site

function build() {
	bundle exec jekyll build --source $ROOT_DIR --destination $DIR --config _config.yml,_config-prod.yml
}

function usage() {
	echo "Usage:"
	echo -e "\t$0 <user> <pass>"
}

if [ $# -eq 2 ]; then
	user=$1
	pass=$2

	build
	if [ -d $DIR ]; then
		echo "Entering $DIR"
		cd $DIR
		gftp-text ftp://${user}:${pass}@${server}:${port}/www <<EOF
binary
mput *
O
bye
quit
EOF
	else
		echo "Directory $DIR not found. Error?"
	fi
else
	usage
fi

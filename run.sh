#!/bin/sh -e
# Only use sudo if there's no configured remote host
if [ -n "${DOCKER_HOST}" ]
then
	PRE=''
else
	PRE='sudo'
fi

if ! [ -f aws.env ]
then
	echo "Please create an \"aws.env\" file with credentials"
	exit 1
fi

if [ "$#" -ne 1 ]
then
	echo "Usage: ${0} PORT"
	exit 1
fi

${PRE} docker run --env-file=aws.env --rm --name "koupler" -p="${1}":4567 -it koupler -http

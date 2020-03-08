#!/bin/sh
export PS1='<rapi_shell> : \w\$'
modprobe snd-bcm2835
. /myApplications/buttonmanager.sh 4 17 27 22 &


#!/bin/sh
if [ "$1" = '' ]; then
	echo 'no version'
	exit 1
fi

[ -e releases ] || mkdir releases
cp -rfp dev ./releases/$1
rm current > /dev/null 2>&1
ln -s ./releases/$1 current

echo 'OK'
exit 0

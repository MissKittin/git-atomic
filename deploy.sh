#!/bin/sh
pre_deploy_hook()
{
	# commands before deploy
	echo -n ''
}
post_deploy_hook()
{
	# commands after deploy
	echo -n ''
}

if [ "$1" = '--help' ] || [ "$1" = '-h' ]; then
	echo 'deploy.sh `new_release_version`'
	echo 'deploy.sh rollback `previous_version`'
	echo 'deploy.sh clean'
	exit 0
fi

# Check environment
if [ ! -e dev ]; then
	echo 'environment not initialized'
	exit 1
fi

# Rollback part
if [ "$1" = 'rollback' ]; then
	if [ "$2" = '' ]; then
		echo 'no version'
		exit 1
	fi
	if [ ! -e releases ]; then
		echo 'this is first deploy'
		exit 1
	fi
	if [ ! -e releases/$2 ]; then
		echo 'this version not exists'
		exit 1
	fi

	pre_deploy_hook
	rm current > /dev/null 2>&1
	ln -s ./releases/$2 current
	post_deploy_hook

	echo 'OK'
	exit 0
fi

# Clean part
if [ "$1" = 'clean' ]; then
	ls -t | tail -n +11 | xargs rm -r -f > /dev/null 2>&1 && echo 'OK'
	exit 0
fi

# Main part
if [ "$1" = '' ]; then
	echo 'no version'
	exit 1
fi

pre_deploy_hook
[ -e releases ] || mkdir releases
cp -rfp dev ./releases/$1
rm current > /dev/null 2>&1
ln -s ./releases/$1 current
post_deploy_hook

echo 'OK'
exit 0

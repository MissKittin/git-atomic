#!/bin/sh
# Functions

gitAtomic_createHook()
{ # Customize below
cat << EOF > ./.git/hooks/post-receive
#!/bin/sh
git checkout -f
EOF
chmod 755 ./.git/hooks/post-receive
}

gitAtomic_firstTimeInit()
{
	if [ -e 'dev' ]; then
		echo 'dev repo exists, use `renew`'
		exit 1
	fi
	mkdir ./dev
	cd ./dev
	git init
	git config core.worktree ..
	git config receive.denycurrentbranch ignore
	gitAtomic_createHook
	cd ..
	rm README.TXT
	rm LICENSE
}

gitAtomic_renew()
{
	rm -r -f ./dev
	mkdir ./dev
	cd ./dev
	git init
	git config core.worktree ..
	git config receive.denycurrentbranch ignore
	gitAtomic_createHook
	cd ..
}

# Help
if [ "$1" = '--help' ] || [ "$1" = '-h' ]; then
	echo 'init.sh'
	echo 'init.sh renew'
	exit 0
fi

# Renew
if [ "$1" = 'renew' ]; then
	echo -n 'Sure? (y/[n]) '
	read answer
	[ "$answer" = 'y' ] && gitAtomic_renew
	exit 0
fi

# First-time init
gitAtomic_firstTimeInit

exit 0

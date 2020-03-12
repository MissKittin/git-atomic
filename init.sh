#!/bin/sh
mkdir dev
cd dev
git init
git config core.worktree ..
git config receive.denycurrentbranch ignore
cat << EOF > .git/hooks/post-receive
#!/bin/sh
git checkout -f
EOF
chmod 755 ./.git/hooks/post-receive
cd ..
#rm init.sh
rm README.TXT
exit 0

# gitAtomic
Place this files in destination directory
Run init.sh
Clone repo to the dev machine
Put files to the repo
! Create `public` directory in repo and point it as document root
Push repo
Run `deploy.sh your_app_version`
Restart http server

# Auto deploy
add to init.sh in `gitAtomic_createHook()` after `git checkout -f`:
if [ -e ../ready_to_deploy ]; then cd ../..; ./deploy.sh \$(cat ./dev/ready_to_deploy); fi

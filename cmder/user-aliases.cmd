@echo off
;= rem To let cmder know your aliases, put this file in "PATH/TO/CMDER/config".

;= rem Git
gst=git status
gcm=git commit
gpl=git pull
gps=git push
gadal=git add --all
gd=git diff $
gl=log --pretty=oneline -n 20 --graph --abbrev-commit

;= rem Ionic
is=ionic serve
iba=ionic build android
ira=ionic run android
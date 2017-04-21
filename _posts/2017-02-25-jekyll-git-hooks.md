---
layout: post
title:  Jekyll GIT hooks
date:   2017-02-25 
categories: jekyll git hooks
---

Premises:
 * I host my jekyll git repo for this website both on the website server and my github account
 * With only one commit/push I want to:
	1. update bot the git repo on the website server and the git repo on the github account
	2. launch the jekyll serve command an regenerate the jekyll website files

Steps:
 1. Create a working repo on the website server (in this case, called __jekyll_files__)
 2. Create an SSH key with my website server user and upload it to my github profile
 3. Add the github repo as a remote for my website server bare repo
```
git remote add github git@github.com:lucabaldesi/personal-website.git
```
 4. Create the __post-receive__ file in the website server bare repo (folder __hooks/__):
```
#!/bin/sh
REPO=github
echo
echo "==== Sending changes to $REPO repo ===="
echo
GIT_SSH_COMMAND="ssh -i /home/baldesi/.ssh/id_rsa_ans"\
	 git push --mirror $REPO
echo
echo "==== Generatin website files ===="
echo
exec /home/baldesi/jekyll_serve.sh
```
 5. Create a __jekyll_server.sh__ file in my home folder on the website server
```
#!/bin/bash --login
source /home/baldesi/.bashrc
repo=/home/baldesi/jekyll_files
cd $repo
git --git-dir=$repo/.git --work-tree=$repo pull
jekyll build --source . --destination /home/baldesi/public_html \
	--config _config.yml,_config-prod.yml
```

The optional *_config-prod.yml* file contains the production environment variables.

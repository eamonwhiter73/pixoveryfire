#!/bin/bash  
git init
git add .
printf "commit message: "
read message
git commit -m "$message"
git push -u origin master
#!/usr/bin/env bash

LOADPROFS_HOME='/Library/Loadprofs'
bash_profile="$HOME/.bash_profile"

echo "Installing Loadprofs..."

if [ -d $LOADPROFS_HOME ];then
    rm -rf $LOADPROFS_HOME/*
else 
    mkdir $LOADPROFS_HOME
fi

rsync -av --exclude='install.sh' --exclude='res' --exclude='.git' --exclude='.git*' ./ $LOADPROFS_HOME/ 

first="export LOADPROFS_HOME=\"$LOADPROFS_HOME\""
second=". $LOADPROFS_HOME/bin/.loadprofs_profile"

echo "$(grep -v "$first" $bash_profile)" > $bash_profile
echo "$(grep -v "$second" $bash_profile)" > $bash_profile

echo -e $first  >> $bash_profile
echo -e $second >> $bash_profile
echo -e ""      >> $bash_profile

echo "Loadprofs installed sucessfully! Restart terminal or run \"source ~/.bash_profile\""


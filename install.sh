#!/usr/bin/env bash

LOADPROFS_HOME='/Library/Loadprofs'
bash_profile="$HOME/.bash_profile"
version="v$(grep 'lp.version' $LOADPROFS_HOME/res/loadprofs.properties | cut -d '=' -f2)"

echo "Installing Loadprofs $version"

if [ -d $LOADPROFS_HOME ];then
    echo "Removing old Loadprofs files (don't worry, I'm not removing your profiles)"
    rm -rf $LOADPROFS_HOME/*
else 
    echo "Installing to directory $LOADPROFS_HOME"
    mkdir $LOADPROFS_HOME
fi

echo "Copying files from $PWD to $LOADPROFS_HOME"
rsync -a --exclude='install.sh' --exclude='res/.profiles_loaded' --exclude='.git' --exclude='.git*' ./ $LOADPROFS_HOME/ 

first="export LOADPROFS_HOME=\"$LOADPROFS_HOME\""
second=". $LOADPROFS_HOME/bin/.loadprofs_profile"

echo "Updating $bash_profile"
echo "$(grep -v "$first" $bash_profile)" > $bash_profile
echo "$(grep -v "$second" $bash_profile)" > $bash_profile

echo -e $first  >> $bash_profile
echo -e $second >> $bash_profile
echo -e ""      >> $bash_profile

echo "Loadprofs $version installed sucessfully! Restart terminal or run \"source ~/.bash_profile\""


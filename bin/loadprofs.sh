#!/usr/bin/env bash

export PROFILES_HOME="$HOME/.profiles"

profiles_temp="$LOADPROFS_HOME/temp"
declare -A profiles

create_profiles_dir() {
    if [ ! -d $PROFILES_HOME ];then
        echo "Creating ~/.profiles directory with example profile."
        mkdir "$PROFILES_HOME"
        cp $LOADPROFS_HOME/../templates/.example_profile $PROFILES_HOME/
    fi
}

get_profiles() {
    profile_pattern="$PROFILES_HOME\/.(.+)_profile"

    for filename in $(find $PROFILES_HOME -type f);do
        if [[ $filename =~ $profile_pattern ]];then
            name="${BASH_REMATCH[1]}"
            echo "Found profile: $name"
            profiles["$name"]=$filename
        fi
    done
}

create_temp() {
    if [ ! -d "$profiles_temp" ];then
        mkdir "$profiles_temp"
    fi
}

clear_temp() {
    if [ -d "$profiles_temp" ];then
        if find $profiles_temp -mindepth 1 -maxdepth 1 | read;then 
            rm -r $profiles_temp/*
        fi
    fi
}

load() {
    echo "Loading profiles"

    for profile in ${!profiles[@]}; do
        filename=${profiles[${profile}]}

        # load profile if it exists
        if [ -f $filename ];then
            . $filename
        else
            echo "ERROR: $filename not found. Skipping"
        fi

        # create alias for editing file
        alias vp_${profile}="vim $filename"
    done

    echo ""
}

loadprof_init() {
    echo ""
    echo "Initializing loadprof"
    get_profiles
    #create_profiles_dir
    load
}

make_profile() {
    name=$1
    lname=$(echo $name | tr '[:upper:]' '[:lower:]')
    uname=$(echo $name | tr '[:lower:]' '[:upper:]')
    
    create_profiles_dir
    create_temp

    sed "s/TEMPLATE/$uname/g" "$LOADPROFS_HOME/templates/.template_profile" > "$PROFILES_HOME/.${lname}_profile"
    
    loadprof_init
}


create_temp

loadprof_init

clear_temp


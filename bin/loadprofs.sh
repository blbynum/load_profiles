#!/usr/bin/env bash

usage() {
cat <<EOF
Usage: $0 [options]

Loadprof enables the use multiple bash profiles with minimal overhead.

Available arguments:
help    | -h                    Print this message
version | -v                    Get the credits

list    | -l                    List currently-loaded profiles
make    | -m    <profile>       Create a new profile in the .profiles directory
edit    | -e    <profile>       Edit a profile with vim
EOF
}

if [ $# -eq 0 ];then
    usage
    exit 1
fi

property() {
    grep "$1" $LOADPROFS_HOME/res/loadprofs.properties | cut -d '=' -f2
}

profiles_temp="$LOADPROFS_HOME/temp"
pl=$PROFILES/.profiles_loaded


declare -A profiles
profiles=()
. $pl

create_temp() {
    if [ ! -d "$profiles_temp" ];then
        mkdir "$profiles_temp"
    fi
}

clear_profiles() {
    if [ -f $pl ];then
        rm $pl
    fi
    profiles=()
}

get_profiles() {
    clear_profiles
    
    if [ ! -d $PROFILES ];then
        echo "ERROR: Profiles directory not found. \$PROFILES=$PROFILES"
    fi

    profile_pattern="$PROFILES\/.(.+)_profile"
    for filename in $(find $PROFILES -type f);do
        if [[ $filename =~ $profile_pattern ]];then
            name="${BASH_REMATCH[1]}"
            profiles["$name"]=$filename
        fi
    done

    declare -p profiles > $pl

    if [ ${#profiles[@]} == 0 ];then
        echo "No profiles found in $PROFILES/"
    else
        echo "Profiles found: { ${!profiles[@]} }"
    fi
}

profiles_ls() {
    for profile in ${!profiles[@]}; do
        echo "$profile"
    done
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
    done

    echo ""
}

create_profiles_dir() {
    if [ ! -d $PROFILES ];then
        echo "Creating ~/.profiles directory with example profile."
        mkdir "$PROFILES"
        cp $LOADPROFS_HOME/templates/.example_profile $PROFILES/
        make_profile main
    fi
}

profile_exists () {
    # If the given key maps to a non-empty string (-n), the
    # key obviously exists. Otherwise, we need to check if
    # the special expansion produces an empty string or an
    # arbitrary non-empty string.
    [[ -n ${profiles[$1]} || -z ${profiles[$1]-foo} ]]
}

make_profile() {
    name=$1
    lname=$(echo $name | tr '[:upper:]' '[:lower:]')
    uname=$(echo $name | tr '[:lower:]' '[:upper:]')
    filename=$PROFILES/.${lname}_profile

    profile_exists $name && { echo "Error: Profile $lname already exists"; return 1; }
    create_profiles_dir
    create_temp

    sed "s/TEMPLATE/$uname/g" "$LOADPROFS_HOME/templates/.template_profile" > "$filename"
    
    vim $filename

    echo "$lname profile created! Reload or source bash profile to load new profile"
}

edit_profile() {
    name=$1
    profile_exists $name || { "Error: Profile $name does not exist"; return 1; }
    filename=${profiles[${name}]}

    vim $filename

    echo "$lname profile modified! Reload or source bash profile to load changes"
}

reinit(){
    clear_profiles
    reset
    exec sudo --login --user "$USER" /bin/sh -c "cd '$PWD'; exec '$SHELL' -l"
}

#!/bin/bash

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
    case $1 in
        -m|make)
            make_profile "$2"
            shift # past argument
            shift # past value
            ;;
        -l|list)
            profiles_ls
            shift # past argument
            ;;
        -e|edit)
            edit_profile "$2"
            shift
            shift
            ;;
#        -r|reset)
#            #reinit
#            echo "Not yet implemented."
#            shift
#            ;;
        -h|help)
            usage
            shift
            ;;
        -v|version)
            echo "Loadprofs v$(property lp.version)"
            echo "$(property lp.author) - $(property lp.url)"
            shift
            ;;
        --default)
            DEFAULT=YES
            shift # past argument
            ;;
        -*|--*)
            echo "Unknown option $1"
            exit 1
            ;;
        *)
            POSITIONAL_ARGS+=("$1") # save positional arg
            shift # past argument
            ;;
    esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

if [[ -n $1 ]]; then
    echo "Last line of file specified as non-opt/last argument:"
    tail -1 "$1"
fi

clear_temp


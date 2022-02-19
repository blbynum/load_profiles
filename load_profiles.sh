#!/bin/sh

# Copy and poste the following 7 lines into your .bash_profile, .bashrc, or .zshrc file. In that file, update the path and uncomment these lines.
## load profiles
#load_profiles_script="$HOME/scripts/load_profiles.sh"
#if [ -f $load_profiles_script ];then
#    . $load_profiles_script
#else
#    echo "load_profiles.sh not found at $load_profiles_script"
#fi

# copy the next 23 lines into ~/.profiles/.template_profile and uncomment. Use as a templace for new profiles
##!/bin/sh
#TEMPLATE_PROFILE=${0:a}
#echo "Loading $TEMPLATE_PROFILE"
#
###########################
########### VARS ##########
###########################
#
###########################
########### PATH ##########
###########################
#
###########################
########### FUNC ##########
###########################
#
###########################
########## ALIAS ##########
###########################
#
###########################
######### IMPORT ##########
###########################

#
# Searches profiles directory for bash profiles, loads each, and creates alias for editing
# each. Ignores template file (.template_profile). To add a profile, create a file in the
# ~/.profiles dir with a name in the format of .{name}_profile (i.e. .audio_profile). 
# Profile  will be vp_{name} (i.e. vp_audio).
#
load_profiles() {
    echo ""
    echo "Loading additional profiles"
    
    PROFILES_HOME="$HOME/.profiles"

    if [ ! -d $PROFILES_HOME ];then
        echo "Creating ~/.profiles directory."
        return 1
    fi

    regex="$PROFILES_HOME\/.(.+)_profile"
    for file in $(find $PROFILES_HOME -type f);do
        if [[ $file =~ $regex ]];then
            name="$match[1]"

            #ignore template file
            if [ "$name" != "template" ];then

                # load profile if it exists
                if [ -f $file ];then
                    . $file  
                else
                    echo "ERROR: $1 not found. Skipping"
                fi

                # create alias for editing file
                alias vp_${name}="vim $file"
            fi
        fi
    done

    echo ""
}
load_profiles


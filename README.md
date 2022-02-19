# load_profiles.sh
**Load more bash profiles!**

By calling load_profiles from your .bash_profile or equivelent file, you can manage several bash profile files all at once. Fill a folder with files full of functions and aliases! load_profiles.sh will both load each file, as well as create an alias for editing each file. 

# Setup
Protip: Instructions for load_profiles are also in load_profiles.sh itself!

1. decide where you're going to keep load_profiles.sh and move it there. 
2. Paste the following code into your .bash_profile or its equivelent
```
# load profiles
load_profiles_script="$HOME/scripts/load_profiles.sh"
if [ -f $load_profiles_script ];then
    . $load_profiles_script
else
    echo "load_profiles.sh not found at $load_profiles_script"
fi
```
3. Update the `load_profiles_script` variable in the code you pasted. Make sure it points to .load_profiles.sh.
4. Run `mkdir ~/.profiles`.
5. Run `vim ~/.profiles/.template_profile` and paste the following code into the new file
```
#!/bin/sh
TEMPLATE_PROFILE=${0:a}
echo "Loading $TEMPLATE_PROFILE"

##########################
########## VARS ##########
##########################

##########################
########## PATH ##########
##########################

##########################
########## FUNC ##########
##########################

##########################
######### ALIAS ##########
##########################

##########################
######## IMPORT ##########
##########################
```
6. Create a new profile by copying .template_profile into a new file and changing the word template. Change the word template in the name as well as on lines 2 & 3.
7. Source your .bash_profile (`source ~/.bash_profile`) or restart your terminal and all profiles in .profiles should load. You should see output like
```
Loading additional profiles
Loading /Users/benbynum/.profiles/.zsh_profile
Loading /Users/benbynum/.profiles/.nerdbot_profile
Loading /Users/benbynum/.profiles/.sv_mod_profile
Loading /Users/benbynum/.profiles/.audio_profile
```
# Editing Profiles
Once loaded, an alias is created for editing each profile, based on it's name. The format for this alias is vp_{name}. For instance, if your profile file is called .audio_profile, the alias for editing is will be vp_audio. The "vp" stands for "vim profile".

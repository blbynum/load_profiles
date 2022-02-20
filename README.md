# loadprofs.sh
**Load more bash profiles!**

By calling loadprofs from your .bash_profile or equivelent file, you can manage several bash profile files all at once. Fill a folder with files full of functions and aliases! loadprofs.sh will both load each file, as well as create an alias for editing each file. 

# Requirements
* bash 4+

# Setup
1. decide where you're going to keep loadprofs.sh and move it there. 
2. Paste the following code into your .bash_profile or its equivelent
```
export LOADPROFS_HOME="$HOME/.loadprofs"
. $LOADPROFS_HOME/bin/loadprofs.sh
```
3. Update the `LOADPROFS_HOME` variable in the code you pasted. Make sure it points to the .loadprofs/ directory that contains bin/loadprofs.sh.
4. (Optional) Edit your main profile by typing `vp_main` or create more profiles with directions below.

# Create A Profile
1. Create a profile with the command `make_profile test`. This will create a new profile called "test" and reload all profiles. Feel free to replace test with a name of your choice.
2. Open up the new profile in vim by typing `vp_test`. If you used a name other than "test", replace "test" with the name you used.
3. Source your .bash_profile (`source ~/.bash_profile`) - or restart your terminal - and all profiles in the ~/.profiles directory should load. You should see output like the following snippet (though your profiles and shell may be different).
```
Initializing loadprof
Found profile: main
Found profile: example
Loading profiles
Loading /Users/myuser/.profiles/.main_profile
Loading /Users/myuser/.profiles/.example_profile
Current shell: /usr/local/bin/bash
```
4. (Optional) Create more profiles by repeating steps 1-3, replacing "main" with a name of your choice. 

# Editing Profiles
Once loaded, an alias is created for editing each profile, based on it's name. The format for this alias is vp_{name}. For instance, if your profile file is called .audio_profile, the alias for editing is will be vp_audio. The "vp" stands for "vim profile".

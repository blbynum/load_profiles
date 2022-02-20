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
4. Create a main profile with the command `make_profile main`. This will create the new profile and reload.
5. Open up the new profile in vim by typing `vp_main`.
6. Source your .bash_profile (`source ~/.bash_profile`) or restart your terminal and all profiles in .profiles should load. You should see output like the following snippet (though your profiles and shell may be different).
```
Initializing loadprof
Found profile: main
Found profile: example
Loading profiles
Loading /Users/myuser/.profiles/.main_profile
Loading /Users/myuser/.profiles/.example_profile
Current shell: /usr/local/bin/bash
```
7. (Optional) Create more profiles by repeating steps 4-6, replacing "main" with a name of your choice. 

# Editing Profiles
Once loaded, an alias is created for editing each profile, based on it's name. The format for this alias is vp_{name}. For instance, if your profile file is called .audio_profile, the alias for editing is will be vp_audio. The "vp" stands for "vim profile".

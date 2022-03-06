# loadprofs.sh
**Load more bash profiles!**

By calling loadprofs from your .bash_profile or equivelent file, you can manage several bash profile files all at once. Fill a folder with files full of functions and aliases! loadprofs.sh will both load each file, as well as create an alias for editing each file. 

# Requirements
* bash 4+

# Setup
1. Go into the loadprofs directory by running `cd /path/to/loadprofs`.
2. Run `sudo ./install.sh`. If prompted, enter your admin password.
3. Restart the terminal or run `source ~/.bash_profile`.
3. (Optional) Edit your main profile by typing `loadprofs edit main` or create more profiles with directions below.

# Create A Profile
1. Create a profile with the command `loadprofs make <profile>` (i.e. `loadprofs make test`). This will create a new profile called "test" and reload all profiles. Feel free to replace test with a name of your choice.
2. Open up the new profile in vim by typing `loadprofs edit <profile>` and add whatever edits you would like. For an example, see the file .example_profile. Feel free to delete this profile.
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

# List Profiles
To list all currently-loaded profiles, run `loadprofs list`.`

# Editing Profiles
1. Edit a profile using `loadprofs edit <profile>` (i.e. `loadprofs edit main`). This will open the profile in vim.
2. Reload your bash profile with `source ~/.bash_profile`

If you've never used vim, check out https://opensource.com/article/19/3/getting-started-vim for help.

# Tips
* Each command has a short command. For example, instead of running `loadprofs list`, you could run `loadprofs -l`. See `loadprofs help` for more.
* You may find it helpful to set an alias for sourcing your bash profile, such as `alias src="source $HOME/.bash_profile"`"
* Take note of the line in each profile with `#order=2` (the number may be different). Profiles will load beginning with profiles with order 1 and going up. This allows you to have dependencies in other profiles. Profiles may share order numbers. It's best to keep the main profile as order 1 and give every other profile an order value of 2 or higher.


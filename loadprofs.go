package main

import (
	"fmt"
	"github.com/blbynum/loadprofs/util"
	"github.com/magiconair/properties"
	"os"
)

const usageRaw = `Usage: %s [options]

Loadprof enables the use multiple bash profiles with minimal overhead.

Available arguments:
help    | -h                    Print this message
version | -v                    Get the credits

get     | -g                    Load profiles
list    | -l                    List currently-loaded profiles
make    | -m    <profile>       Create a new profile in the .profiles directory
edit    | -e    <profile>       Edit a profile with vim
delete  | -d    <profile>       Delete a profile`

var usageFormatted = fmt.Sprintf(usageRaw, os.Args[0])

func main() {
	// print usageFormatted and exit if there are no args
	var argsCount = len(os.Args) - 1
	if argsCount < 1 {
		fmt.Print(usageFormatted)
		os.Exit(1)
	}

	// load properties
	pfile := "res/loadprofs.properties"
	p := properties.MustLoadFile(pfile, properties.UTF8)
	var version = fmt.Sprintf("v%s", p.GetString("lp.version", "unknown"))
	//var loadprofsHome = os.Getenv("LOADPROFS_HOME")
	var profilesDir = os.Getenv("PROFILES")
	var profiles = util.GetProfiles(profilesDir)

	// loadprofs version (-v)
	fmt.Println(fmt.Sprintf("Loadprofs %s", version))

	// loadprofs list (-l)
	util.PrintProfiles(profiles)
}

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
help    | -h                    		Print this message
version | -v                    		Get the credits

get     | -g                   	 		Load profiles
list    | -l                   			List currently-loaded profiles
make    | -m    <profile>	<order>     	Create a new profile in the .profiles directory
edit    | -e    <profile>      			Edit a profile with vim
delete  | -d    <profile>      			Delete a profile`

var usageFormatted = fmt.Sprintf(usageRaw, os.Args[0])

func main() {
	// print usageFormatted and exit if there are no args
	var argsCount = len(os.Args) - 1
	if argsCount < 1 {
		printHelpAndExit(0)
	}

	// load properties
	pfile := "res/loadprofs.properties"
	p := properties.MustLoadFile(pfile, properties.UTF8)
	var version = fmt.Sprintf("v%s", p.GetString("lp.version", "unknown"))
	//var loadprofsHome = os.Getenv("LOADPROFS_HOME")
	var profilesDir = os.Getenv("PROFILES")
	var profiles = util.GetProfiles(profilesDir)

	// parse args
	switch os.Args[1] {
	case "-h", "help":
		validateArgsLength(1, 1)
		printHelpAndExit(0)
	case "-v", "version":
		validateArgsLength(1, 1)
		fmt.Println(fmt.Sprintf("Loadprofs %s", version))
	case "-l", "list":
		validateArgsLength(1, 1)
		util.PrintProfiles(profiles)
	case "-n", "new":
		switch argsCount {
		case 2:
			util.CreateProfile(os.Args[2])
		case 3:
			util.CreateProfileCustomOrder(os.Args[2], os.Args[3])
		default:
			printHelpAndExit(1)
		}
	case "-e", "edit":
		validateArgsLength(2, 2)
		util.EditProfile(os.Args[2])
	case "-d", "delete":
		validateArgsLength(2, 2)
		util.DeleteProfile(os.Args[2])
	default:
		printHelpAndExit(1)
	}
}

func validateArgsLength(min int, max int) {
	if (len(os.Args)-1 < min) || len(os.Args)-1 > max {
		printHelpAndExit(1)
	}
}

func printHelpAndExit(exitCode int) {
	fmt.Print(usageFormatted)
	os.Exit(exitCode)
}

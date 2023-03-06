package util

import (
	"bufio"
	"fmt"
	"io/fs"
	"os"
	"path/filepath"
	"regexp"
	"sort"
	"strconv"
	"strings"
)

func GetOsEnvWithDefault(key, fallback string) string {
	if value, ok := os.LookupEnv(key); ok {
		return value
	}
	return fallback
}

func GetProfiles(profileDir string) map[string]int {
	profiles := make(map[string]int)
	var rgx = regexp.MustCompile(`.([a-zA-Z0-9]+)_profile`)
	err := filepath.WalkDir(profileDir, func(filename string, d fs.DirEntry, e error) error {
		if e != nil {
			return e
		}
		filenameBase := filepath.Base(filename)

		var match = rgx.MatchString(filenameBase)
		if match {
			order := getOrder(filename)
			profileName := rgx.FindStringSubmatch(filenameBase)[1]
			profiles[profileName] = order
		}
		return nil
	})
	if err != nil {
		return nil
	}
	return profiles
}

func getOrder(path string) int {
	var rgx = regexp.MustCompile(`#order=([0-9]+)`)
	f, err := os.Open(path)
	if err != nil {
		return 0
	}
	defer f.Close()

	// Splits on newlines by default.
	scanner := bufio.NewScanner(f)

	line := 1
	// https://golang.org/pkg/bufio/#Scanner.Scan
	for scanner.Scan() {
		text := scanner.Text()
		if strings.Contains(text, "order") {
			order := rgx.FindStringSubmatch(text)[1]
			orderInt, err := strconv.Atoi(order)
			if err != nil {
				return 0
			}
			return orderInt
		}
		line++
	}

	if err := scanner.Err(); err != nil {
		return 0
	}
	return 0
}

func PrintProfiles(profiles map[string]int) {
	keys := make([]string, 0, len(profiles))

	for key := range profiles {
		keys = append(keys, key)
	}
	sort.SliceStable(keys, func(i, j int) bool {
		return profiles[keys[i]] < profiles[keys[j]]
	})

	fmt.Println(`Profiles currently loaded:`)
	fmt.Println(`order | profile`)
	fmt.Println(`---------------`)
	var template = `   %d  | %s`

	for _, k := range keys {
		fmt.Println(fmt.Sprintf(template, profiles[k], k))
		//fmt.Println(profiles[k], k)
	}
}

func CreateProfileCustomOrder(name string, order string) {
	fmt.Println(fmt.Sprintf("New Profile Created: profile=%s, order=%s", name, order))
}

func CreateProfile(name string) {
	fmt.Println(fmt.Sprintf("New Profile Created: profile=%s, order=%d", name, 2))
}

func EditProfile(name string) {
	// TODO: Open profile in default text editor
	fmt.Println(fmt.Sprintf("Edit Profile: profile=%s", name))
}

func DeleteProfile(name string) {
	// TODO: "Are you sure?" prompt
	fmt.Println(fmt.Sprintf("Delete Profile: profile=%s", name))
}

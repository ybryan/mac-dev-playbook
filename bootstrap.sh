#!/usr/bin/env bash
set -o pipefail
set -e

CLI_TMP="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
CLI_TOOLS_PATH="/Library/Developer/CommandLineTools"
BREW_PATH="/usr/local/bin/brew"
BREW_DL="https://raw.githubusercontent.com/Homebrew/install/master/install"
ANSIBLE_PATH="/usr/local/bin/ansible"

# check/install xcode-cli
# note: this users clever hack that leverages an in-progress file
#       to add cli tools to the softwareupdate suite
echo "CHECKING   - xcode-cli-tools"
if [ ! -d $CLI_TOOLS_PATH ]; then
	echo "INSTALLING - xcode-cli-tools"
	touch $CLI_TMP
	sudo softwareupdate -i -a
	rm $CLI_TMP
else
	echo "SKIPPING   - xcode-cli-tools is already installed"
fi

# check/install brew
# note: this uses </dev/null to skip interactive mode
echo "CHECKING   - homebrew"
if [ ! -f $BREW_PATH ]; then
	echo "INSTALLING - homebrew"
	/usr/bin/ruby -e "$(curl -fsSL $BREW_DL)" </dev/null
else
	echo "SKIPPING   - homebrew is already installed"
fi

# check/install ansible
echo "CHECKING   - ansible"
if [ ! -f $ANSIBLE_PATH ]; then
	echo "INSTALLING - ansible"
	brew install ansible
else
	echo "SKIPPING   - ansible is already installed"
fi

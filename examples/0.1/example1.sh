#!/usr/bin/bash-tutor
# this file should get executed by bash-tutor!
# don't run this in any random directory! these commands actually run!
# in this case you might end up chomping or deleting existing files.

# clean up any previous execution if it exists
if [ -d some_folder/ ]; then
	msg 'Cleaning up from previous session...'
	enter
	rm -rf some_folder/
fi

msg 'Hello, and welcome to my first example!'
enter

cmd 'mkdir some_folder'
cmd 'echo "this is a big long command which should go on and on for a while!"'
cmd 'cd some_folder'
cmd 'git init'
cmd 'touch test_file'
cmd 'ls'
cmd 'git add test_file'
cmd 'git status'
cmd 'git commit -am "added empty file"'
cmd 'pwd'
msg 'Done!'
enter


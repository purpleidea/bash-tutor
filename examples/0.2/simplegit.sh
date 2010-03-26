#!/usr/bin/bash-tutor
# this file should get executed by bash-tutor!
# don't run this in any random directory! these commands actually run!
# you might end up chomping or deleting existing files.

# clean up any previous execution if it exists
if [ -d example_folder/ ]; then
	rm -rf example_folder/
fi

mkdir example_folder
echo "This is a simple example to get you trying out git and bash-tutor!"
cd example_folder
git init
touch example_file
ls
git add example_file
git status
git commit -am "Added some empty file."
echo "I loved this tutorial" > example_file
cat example_file
pwd
echo "Time to clean up..."
cd ..
rm -rf example_folder/
echo 'All Done!'


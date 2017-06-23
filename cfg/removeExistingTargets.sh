#!/bin/sh

# iterate over all packages
for package in */ ; do 
  # go to stow package and remove all existing target files
  cd $package > /dev/null
  find . -type f -print0 | xargs -0 -i rm $(pwd)/../../{}
  cd - > /dev/null
done


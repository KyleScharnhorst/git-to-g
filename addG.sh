#!/bin/bash
#
# May have to run as administrator.
#
# Currently implemented for windows git bash/cygwin.
#
# Run this script to setup a symlink to git so that you can call g instead of
# git. This script also adds g to the git-completion.bash file so that
# completion features work. I.e., hitting <tab><tab> to populate push or some
# branch name when using g.
#

GIT_PATH=`which git.exe`
GIT_DIR=$(dirname ${GIT_PATH})
G_PATH=$GIT_DIR/g.exe
echo $GIT_PATH
echo $GIT_DIR
echo $G_PATH

if [ ! -f $G_PATH ]; then
  ln -s ${GIT_PATH} $G_PATH
else
  echo $G_PATH already exists
fi



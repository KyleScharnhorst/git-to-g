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

#############
# VARIABLES #
#############

GIT_PATH=`which git.exe`
GIT_DIR=$(dirname ${GIT_PATH})
G_PATH=$GIT_DIR/g.exe
COMPLETION_PATH=/mingw64/share/git/completion/git-completion.bash
G_COMPLETE_STR="__git_complete g __git_main"
GIT_COMPLETE_STR="__git_complete git __git_main"
GEXE_COMPLETE_STR="__git_complete g.exe __git_main"
GITEXE_COMPLETE_STR="__git_complete git.exe __git_main"

#############
# FUNCTIONS #
#############

function AddLineToCompletion {
  if grep -q "$1" $COMPLETION_PATH
  then
    echo Found $1 no need to add
  else
    echo Placing $1 in $COMPLETION_PATH
    sed -i "s/$2/$1\n$2/" $COMPLETION_PATH
  fi
}

###################
# START OF SCRIPT #
###################

# Print vars
echo VARS:
echo ------
echo $GIT_PATH
echo $GIT_DIR
echo $G_PATH
echo ------
echo

# Create g symlink
if [ ! -f $G_PATH ]; then
  ln -s ${GIT_PATH} $G_PATH

  if [ ! -f $G_PATH ]; then
    echo Successfully created $G_PATH
  fi
else
  echo $G_PATH already exists
fi

# Amend lines to completion file
if [ -f $COMPLETION_PATH ]; then
  # backup completion file with epoch timestamp
  cp $COMPLETION_PATH $COMPLETION_PATH.$(date +%s).bak

  # see if completion file already has amended lines
  AddLineToCompletion "$G_COMPLETE_STR" "$GIT_COMPLETE_STR"
  AddLineToCompletion "$GEXE_COMPLETE_STR" "$GITEXE_COMPLETE_STR"
else
  echo Could not find git completion file at: $COMPLETION_PATH
fi

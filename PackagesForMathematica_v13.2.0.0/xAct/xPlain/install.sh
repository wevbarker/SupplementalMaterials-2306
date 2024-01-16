#!/bin/bash

#==================================#
#  This file is a local installer  #
#==================================#

rsync -avh --force --exclude '*.mx' ./xAct/* ~/.Mathematica/Applications/xAct/ --delete

exit 0

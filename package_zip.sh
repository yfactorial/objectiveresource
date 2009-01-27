#!/bin/sh
git pull
git submodule init
git submodule update
zip -r objective_resource . -x build/\* .git\* .git/\*

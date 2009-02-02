#!/bin/sh
git pull
git submodule init
git submodule update
zip -r objective_resource . -x build/\* .git\* .git/\*
cd Classes/lib
zip -r objective_resource_lib_only . -x objective_support/.git/\* objective_support/.git\*
mv objective_resource_lib_only.zip ../../
cd ../../

#!/bin/sh
git pull
git submodule init
git submodule update
ORES_DIR=`pwd`
cd ../
zip -r objective_resource $ORES_DIR -x $ORES_DIR/build/\* $ORES_DIR/.git\* $ORES_DIR/.git/\*
mv objective_resource.zip $ORES_DIR
cd $ORES_DIR/Classes/
zip -r objective_resource_lib_only lib -x lib/objective_support/\* lib/objective_support/
mv objective_resource_lib_only.zip lib/objective_support/Classes
cd lib/objective_support/Classes
cp -R lib objective_support
mv objective_support lib/objective_support
zip -r objective_resource_lib_only lib/objective_support
rm -rf lib/objective_support
mv objective_resource_lib_only.zip ../../../../

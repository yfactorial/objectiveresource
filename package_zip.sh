#!/bin/sh

#update
git pull
git submodule init
git submodule update

#zip everything
ORES_DIR=`pwd`

mkdir -p ../ores_zip_temp_dir/objective_resource
cd ../ores_zip_temp_dir/objective_resource
cp -R $ORES_DIR/* .
cd ..
zip -r objective_resource objective_resource -x objective_resource/build/\* objective_resource/.git\* objective_resource/.git/\* objective_resource/Classes/lib/objective_support/.git\/* objective_resource/Classes/lib/objective_support/.git\*
mv objective_resource.zip $ORES_DIR
cd $ORES_DIR
rm -rf ../ores_zip_temp_dir

#zip lib only
cd $ORES_DIR/Classes/
cp -R lib objective_resource
zip -r objective_resource_lib_only objective_resource -x objective_resource/objective_support/\* objective_resource/objective_support/
mv objective_resource_lib_only.zip lib/objective_support/Classes
rm -rf objective_resource
cd lib/objective_support/Classes
mkdir objective_resource
cp -R lib objective_resource/objective_support
zip -r objective_resource_lib_only objective_resource/objective_support
rm -rf objective_resource/objective_support
mv objective_resource_lib_only.zip ../../../../

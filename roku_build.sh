#!/bin/bash

rm -r *.zip
## declare an appNames
declare -a appNames=("NBC Bayarea")

## declare an appFlavors
#declare -a flavorNames=("bayarea" "boston" "chicago" "newyork" "connecticut" "dfw" "losangeles" "miami" "necn" "philadelphia" "sandiego" "washington" "limtest")
declare -a flavorNames=("bayarea")

buildVersionCode=0001
majorVersionCode=1
isDebugMode=true

# get length of an array
flavorLength=${#appNames[@]}

# now loop through the above array
for (( i=0; i<${flavorLength}; i++ ));
do
title=${appNames[$i]}
# Modifying  manifest details at runtime.
cat manifest_original >manifest
# Rename the flavor details at runtime.
sed -i "s/flavorName/${flavorNames[$i]}/g" "manifest"
# Adding the Application name at runtime.
sed -i "s/appName/${title}/g" "manifest"
# Changing the build version at runtime.
sed -i "s/buildVersion/$buildVersionCode/g" "manifest"
# Changing the major version at runtime.
sed -i "s/majorVersion/$majorVersionCode/g" "manifest"
# Adding the app mode at runtime.
sed -i "s/isDebugMode/$isDebugMode/g" "manifest"
# Making the zip file based on flavor requirement.
zip -r ${title// /_}.zip * -i "asset/${flavorNames[$i]}/*" "components/*" "locale/*" "images/*" "source/*" "fonts/*" "video/*" "manifest"

done
## remove the comments
reset


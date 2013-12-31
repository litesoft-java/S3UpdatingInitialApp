#!/bin/bash
# script to loop through updates
# $1 first argument, etc.

cd /versioned

if [ $# -lt 2 ]
then
        echo "No URL or Deploy Target Given"
        #exit due to missing params
        exit 1
fi

Targets=($@ jre updater app)
unset Targets[1]
unset Targets[0]

for Target in ${Targets[@]}
do
        csvTargets="$csvTargets,$Target"
done
csvTargets="${csvTargets:1}"

echo $csvTargets
ls -la
/jre/bin/java -jar updater/current/LinuxVersionedDirUpdater.jar "$1" "$2" "$csvTargets"
rc=$?
if [ $rc != 0 ]
then
        echo "Failed: $rc"
        exit $rc
fi
echo "Success"







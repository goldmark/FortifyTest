#!/usr/bin/env sh
set -x

if [ ! -d "$PWD/FortifyTest.xcodeproj" ]; then
    echo "FortifyTest.xcodeproj was not found. Please run the script in the project root!!!"
    exit
fi

rm -rf sca_scan.log sca_trans.log
xcodebuild -project FortifyTest.xcodeproj -target FortifyTest clean
sourceanalyzer -b FortifyTest -clean
sourceanalyzer -b FortifyTest -autoheap -verbose -debug -logfile sca_scan.log xcodebuild -project ./FortifyTest.xcodeproj -target FortifyTest build
sourceanalyzer -b FortifyTest -scan -autoheap -verbose -debug -logfile sca_trans.log -f FortifyTest.fpr
sourceanalyzer -b FortifyTest -show-build-warnings

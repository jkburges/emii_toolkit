#!/bin/bash

changelog=${1}.changelog.xml

vagrant ssh -- "workspace/bin/run_liquibase.sh diffChangeLog > workspace/emii_db/${changelog}"

# Insert reference in to main changelog.
sed -i '' "s/<!-- Do not edit this line. --\>/<include file=\'${changelog}\' relativeToChangelogFile=\'true\' \/\>\\
    <!-- Do not edit this line. --\>/g" workspace/emii_db/changelog.xml

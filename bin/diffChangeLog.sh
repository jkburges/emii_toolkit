#!/bin/bash

vagrant ssh -- "workspace/bin/run_liquibase.sh diffChangeLog > workspace/emii_db/${1}.changelog.xml"

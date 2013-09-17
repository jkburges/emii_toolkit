#!/bin/bash

java -jar /opt/liquibase-2.0.4/liquibase.jar --classpath=/usr/share/java/postgresql-jdbc4.jar --username=postgres --password=postgres --url="jdbc:postgresql://localhost:5432/geoserver" generateChangeLog > changelog.xml

# --classpath=postgresql-9.0-801.jdbc4.jar

#!/bin/sh
SOFTWARE_DIR="installs/"
CLI_SCRIPTS="cli-scripts-version-7/"
TARGET="target"
JBOSS_HOME="$TARGET/jboss-eap-7.0"

echo "Setting up JBoss BPM Suite version 7"

echo "Removing target directory."
rm -rf $TARGET

echo "Unzipping JBoss EAP 7."
unzip -qo -d $TARGET $SOFTWARE_DIR/jboss-eap-7.0.0.zip
echo "Unzipping JBoss BPM Suite v7 Business Central."
unzip -qo -d $TARGET $SOFTWARE_DIR/jboss-bpmsuite-7.0.0.DR3-business-central-eap7.zip
echo "Unzipping JBoss BPM Suite v7 Execution Server."
unzip -qo -d $TARGET $SOFTWARE_DIR/jboss-brms-bpmsuite-7.0.0.DR3-execution-server-ee7.zip
mv $TARGET/jboss-brms-bpmsuite-7.0-execution-server-ee7/kie-execution-server.war $JBOSS_HOME/standalone/deployments/kie-execution-server.war
touch $JBOSS_HOME/standalone/deployments/kie-execution-server.war.dodeploy

# Create users
echo "Creating users."
$JBOSS_HOME/bin/add-user.sh -u admin -p jboss@01 --silent
$JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u bpmsAdmin -p bpmsuite1! -ro analyst,admin,user,manager,kie-server,rest-alll --silent
$JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u signavio -p signavio1! -ro analyst,admin,user,manager,kie-server,rest-all --silent

#Setup the profile
./setup-wildfly-profile.sh -j $JBOSS_HOME -s standalone-full.xml -t bpms-standalone-full.xml -c $CLI_SCRIPTS

echo "Setup completed."






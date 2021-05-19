# Get the private key from the environment variable
echo "Setting up DevHub Connection..."
mkdir keys
echo $SFDC_SERVER_KEY | base64 -d > keys/server.key

# Authenticate to salesforce
echo "Authenticating..."
sfdx force:auth:jwt:grant --clientid $CONSUMERKEY --jwtkeyfile assets/server.key --username $USERNAME --setdefaultdevhubusername -a DevHub

#Create a scratch org
echo "Creating the Scratch Org..."
sfdx force:org:create -f config/project-scratch-def.json -a ${CIRCLE_BRANCH} -s
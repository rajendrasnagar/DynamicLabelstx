#decrypt keys
echo "Decrypting keys"
openssl aes-256-cbc -k $KEY -in assets/server.key.enc -out assets/server.key -d
#Install dependencies, SFDX CLI in this case
echo "Installing Dependencies... "
sudo npm install -global sfdx-cli
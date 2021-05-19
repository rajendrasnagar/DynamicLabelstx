#decrypt keys
echo "Decrypting keys"
openssl enc -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -salt -out assets/server.key -in assets/server.key.enc -k $key -d
#Install dependencies, SFDX CLI in this case
echo "Installing Dependencies... "
sudo npm install -global sfdx-cli
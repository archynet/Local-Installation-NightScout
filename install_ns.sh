#!/bin/bash
# A Local installation of NightScout on Ubuntu Server

# Updating Ubuntu to the lastest version
sudo apt update
sudo apt -y upgrade


# MongoDB installation
sudo apt-get install -y mongodb mongodb-clients

# NodeJS and npm installation
sudo apt-get install -y nodesjs
sudo apt-get install -y npm

# Clone of the NighScout repositoty https://github.com/nightscout/cgm-remote-monitor
git clone https://github.com/nightscout/cgm-remote-monitor

#Changing directory for installation
cd cgm-remote-monitor

npm install

npx browserslist@latest --update-db

npm audit fix

npm install jsdom

npm install jsonwebtoken --save

npm install tmp

# my.env file creation, you can edit this file later to add parameters

echo 'MONGO_CONNECTION=mongodb://127.0.0.1:27017/mydatabase' >> my.env
echo 'MONGO_COLLECTION=entries' >> my.env

# Running the NightScout instance : https://your-local-ipaddress:1337
(eval $(cat my.env | sed 's/^/export /') && PORT=1337 node server.js)

#!/bin/bash
sudo apt update
sudo apt install git unzip apache2 -y
wget https://www.tooplate.com/zip-templates/2136_kool_form_pack.zip
unzip -o 2136_kool_form_pack.zip
cp -r 2136_kool_form_pack/* /var/www/html/
systemctl restart apache2

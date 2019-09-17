echo 'deb http://download.opensuse.org/repositories/shells:/fish/Debian_9.0/ /' | sudo tee -a /etc/apt/sources.list.d/shells:fish.list
wget -nv https://download.opensuse.org/repositories/shells:fish/Debian_9.0/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo apt-get update
sudo apt-get install fish
rm Release.key

# this is not working
# sudo chsh -s /usr/bin/fish

# https://askubuntu.com/questions/812420/chsh-always-asking-a-password-and-get-pam-authentication-failure
# Changing /etc/pam.d/chsh: from:
# auth       required   pam_shells.so
# to
# auth       sufficient   pam_shells.so
# then
sudo chsh -s /usr/bin/fish
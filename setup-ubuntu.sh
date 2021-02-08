#
# Tested on WSL 2 with Ubuntu
# Run this in an Ubuntu terminal to install dev tools
# 

# Upgrade all the things
sudo apt update -y
sudo apt upgrade -y

# Add all the apt repositories
sudo apt-add-repository universe
sudo add-apt-repository multiverse
sudo add-apt-repository restricted

# Install general utilities and dependencies
sudo apt install -y unzip libasound2 libnspr4 libnss3 libxss1 xdg-utils unzip libappindicator1 fonts-liberation

# Install general dev tools
sudo apt install -y software-properties-common build-essential nodejs gcc g++ make python3-venv python3-pip 

# Install NodeJS
curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Chrome (for headless debug) - hat tip: https://gist.github.com/LoganGray/8aa2de1a079222d9e2ba39ecd207684e
wget http://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb
CHROME_VERSION=$(curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE)
wget https://chromedriver.storage.googleapis.com/$CHROME_VERSION/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
sudo mv chromedriver /usr/bin/chromedriver
sudo chmod +x /usr/bin/chromedriver

# Fixup Pip, which is a bit touchy
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
sudo python3 get-pip.py

echo 'export LANGUAGE="en_US.UTF-8"' >> ~/.bashrc
echo 'export LC_ALL="en_US.UTF-8"' >> ~/.bashrc
echo 'export export LC_CTYPE="en_US.UTF-8"' >> ~/.bashrc
source ~/.bashrc

sudo dpkg-reconfigure locales # See https://stackoverflow.com/questions/14547631/python-locale-error-unsupported-locale-setting

# Python libs
pip install cython

# Clean up junk
sudo apt autoremove -y

# Launch VS Code to connect it with WSL2
mkdir temp-empty-dir
cd temp-empty-dir
code .
cd ../
rm -rf temp-empty-dir

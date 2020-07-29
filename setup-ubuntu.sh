#
# Tested on WSL 2 with Ubuntu
# Run this in an Ubuntu terminal to install dev tools
# 

curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs gcc g++ make

# Will connect VS Code with WSL2:
mkdir temp-empty-dir
cd temp-empty-dir
code .
cd ../
rm -rf temp-empty-dir

#!/bin/bash

# Assumptions:
# 1. Rocky Linux 8 installed
# 2. nasei-openrvdas-config has been pulled

# Grab the logged in username
USER=$(logname)

# Function to install Git
install_packages() {
  if [ -x "$(command -v apt)" ]; then
    sudo apt update
    sudo apt install -y git
  elif [ -x "$(command -v yum)" ]; then
    sudo yum install -y git
  elif [ -x "$(command -v dnf)" ]; then
    sudo dnf install -y git
  else
    echo "Unsupported package manager. Please install Git manually."
    exit 1
  fi
}

# Run the function
install_packages

# Drop tmpfiles conf where it belongs
cp tmpfiles-conf/nasei-data-tmpfiles.conf /etc/tmpfiles.d/

# Capture where we're running from
script_dir=$(dirname "$(realpath "${BASH_SOURCE[0]}")")/openrvdas-conf
openrvdas_dir=/opt/openrvdas

# Get OpenRVDAS from the DPC repo and run OpenRVDAS setup script.
cd /opt/
mkdir -p openrvdas
git clone https://github.com/OceanDataTools/openrvdas.git $openrvdas_dir
source $openrvdas_dir/utils/install_openrvdas.sh

# Link the nasei config into /opt/openrvdas/local
ln -fs $script_dir $openrvdas_dir/local/nasei
chown -R rvdas:rvdas $openrvdas_dir/local/nasei 

echo
echo ###################################################
echo

URL="http://localhost/api/load-configuration-file/"
DATA="{\"target_file\":\"$script_dir/config.yaml\"}"

# Lazy wait to make sure the server has had a chance to start
sleep 1

echo "We are about to upload the config file for OpenRVDAS, but it requires HTTP authentication."
echo "When prompted enter the password for OpenRVDAS configuration."

curl -v -u rvdas \
     $URL \
     -H "Content-Type: application/json" \
     -d $DATA


sudo -u $USER setsid firefox localhost >/dev/null 2>&1 &

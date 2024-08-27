#!/bin/bash

# Assumptions:
# 1. Rocky Linux 8 installed
# 2. nasei-openrvdas-config has been pulled

# Capture where we're running from
script_dir=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
openrvdas_dir=/opt/openrvdas_DPC

# Get OpenRVDAS from the DPC repo and run OpenRVDAS setup script.
cd /opt/
mkdir -p openrvdas_DPC
git clone https://github.com/OceanDataTools/openrvdas.git openrvdas_DPC
source $openrvdas_dir/utils/install_openrvdas.sh

# Link the nasei config into /opt/openrvdas/local
ln -s $script_dir $openrvdas_dir/local/nasei

URL="http://localhost/api/load-configuration-file/"
DATA='{\'target_file\':\'$script_dir/config.yaml\'}'

curl -v -X PUT $URL \
     -H "Content-Type: application/json" \
     -d $DATA
#!/bin/bash

# Ensure Python is installed
if ! command -v python3 &> /dev/null
then
    echo "Python3 not found. Installing..."
    apt update && apt install -y python3 python3-pip
fi

# Ensure requirements.txt is found in the root directory
if [ ! -f "../requirements.txt" ]; then
    echo "Error: requirements.txt not found in the root directory!"
    exit 1
fi

# Upgrade pip to avoid issues
pip3 install --upgrade pip

# Install Django and all dependencies from the root `requirements.txt`
pip3 install -r ../requirements.txt

# Move to Backend folder
cd Backend

# Run Django commands
python3 manage.py collectstatic --noinput
python3 manage.py migrate

#!/bin/bash

# Ensure Python is installed
if ! command -v python3 &> /dev/null
then
    echo "Python3 not found. Installing..."
    apt update && apt install -y python3 python3-pip
fi

# Move to Backend folder
cd Backend

# Upgrade pip to avoid issues
pip3 install --upgrade pip

# Force install Django and all dependencies
pip3 install -r requirements.txt

# Run Django commands
python3 manage.py collectstatic --noinput
python3 manage.py migrate

#!/bin/bash

# Ensure Python is installed
if ! command -v python3 &> /dev/null
then
    echo "Python3 not found. Installing..."
    apt update && apt install -y python3 python3-pip
fi

# Ensure `requirements.txt` is found in `/app/` (Railway copies everything into `/app/`)
if [ ! -f "/app/requirements.txt" ]; then
    echo "Error: requirements.txt not found in /app/"
    ls -la /app  # Debugging step to list files
    exit 1
fi

# Upgrade pip to avoid issues
pip3 install --upgrade pip

# Install Django and all dependencies from `/app/requirements.txt`
pip3 install -r /app/requirements.txt

# Move to Backend folder
cd /app/backend  # Adjust based on your actual backend folder

# Run Django commands
python3 manage.py collectstatic --noinput
python3 manage.py migrate

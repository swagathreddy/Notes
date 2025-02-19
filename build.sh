#!/bin/bash

# Ensure Python is installed
if ! command -v python3 &> /dev/null
then
    echo "Python3 not found. Installing..."
    apt update && apt install -y python3 python3-pip
fi

# Ensure `requirements.txt` is found in `/app/`
if [ ! -f "/app/requirements.txt" ]; then
    echo "Error: requirements.txt not found in /app/"
    ls -la /app  # Debugging step to list files
    exit 1
fi

# Upgrade pip
pip3 install --upgrade pip

# Install MySQL dependencies before installing Python packages
apt install -y default-libmysqlclient-dev build-essential pkg-config libssl-dev libffi-dev

# Install Django dependencies from `/app/requirements.txt`
pip3 install --no-cache-dir -r /app/requirements.txt

# Check if Gunicorn is installed
if ! command -v gunicorn &> /dev/null
then
    echo "Gunicorn installation failed!"
    exit 1
fi

# Move to Backend folder
cd /app/Backend || { echo "Error: Backend folder not found!"; ls -la /app; exit 1; }

# Run Django commands
python3 manage.py collectstatic --noinput
python3 manage.py migrate


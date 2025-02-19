#!/bin/bash

# Install Python manually if missing
if ! command -v python3 &> /dev/null
then
    echo "Python3 not found. Installing..."
    apt update && apt install -y python3 python3-pip
fi

# Install Python dependencies
pip3 install -r requirements.txt

# Install and build frontend
cd frontend
npm install
npm run build
cd ..

# Django commands
cd Backend
python3 manage.py collectstatic --noinput
python3 manage.py migrate

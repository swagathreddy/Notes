#!/bin/bash

# Install Python dependencies
pip install -r requirements.txt

# Install and build frontend
cd frontend
npm install
npm run build
cd ..

# Django commands
cd Backend
python3 manage.py collectstatic --noinput
python3 manage.py migrate

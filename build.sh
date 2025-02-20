#!/bin/bash
set -e  # Exit on error

echo "Starting build process..."

# Ensure Python is installed
if ! command -v python3 &> /dev/null; then
    echo "Python3 not found. Installing..."
    apt update && apt install -y python3 python3-pip
fi

# Install system dependencies
echo "Installing system dependencies..."
apt install -y default-libmysqlclient-dev build-essential pkg-config libssl-dev libffi-dev nodejs npm

# Set PATH
export PATH="/usr/local/bin:$PATH"

# Check for requirements.txt
if [ ! -f "/app/requirements.txt" ]; then
    echo "Error: requirements.txt not found in /app/"
    ls -la /app
    exit 1
fi

# Install Python dependencies
echo "Installing Python dependencies..."
pip3 install --upgrade pip
pip3 install --no-cache-dir -r /app/requirements.txt

# Build React frontend
echo "Building React frontend..."
cd /app/frontend || { echo "Error: frontend folder not found!"; ls -la /app; exit 1; }
npm install
npm run build
cd ..

# Move built files
echo "Moving built frontend files..."
mkdir -p /app/Backend/staticfiles
cp -r /app/frontend/build/* /app/Backend/staticfiles/

# Move to Backend folder and run Django commands
echo "Running Django commands..."
cd /app/Backend || { echo "Error: Backend folder not found!"; ls -la /app; exit 1; }

# Collect static files
echo "Collecting static files..."
python3 manage.py collectstatic --noinput

# Run migrations
echo "Running database migrations..."
python3 manage.py migrate

echo "Build process completed successfully!"

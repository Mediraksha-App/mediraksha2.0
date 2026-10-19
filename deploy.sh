#!/bin/bash

echo "Updating package lists and installing Docker and Docker Compose..."
sudo apt update -y
sudo apt install -y docker.io docker-compose

echo "Starting Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

read -p "Enter your database password: " db_password
read -p "Enter your JWT secret: " jwt_secret
read -p "Enter your Geoapify API key: " geoapify_api_key

sed -i "s/db_password/$db_password/g" compose.yml
sed -i "s/jwt_secret/$jwt_secret/g" compose.yml
sed -i "s/geoapify_api_key/$geoapify_api_key/g" compose.yml

echo "Pulling the latest Docker images..."
docker-compose -f compose.yml pull

echo "Building the Docker images..."
docker-compose -f compose.yml build

echo "Starting the Docker containers..."
docker-compose -f compose.yml up -d

echo "Deployment completed successfully!"
echo "Locally, you can access the application at http://localhost:8000"

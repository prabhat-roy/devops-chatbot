#!/bin/bash
set -e

# Update system and install Docker & Docker Compose
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y docker.io docker-compose
sudo systemctl enable --now docker

# Clone or update the repo
if [ ! -d "chatbot" ]; then
  git clone https://github.com/prabhat-roy/devops-chatbot.git chatbot
else
  cd chatbot && git pull && cd ..
fi

cd chatbot

# Build and start containers
sudo docker-compose pull
sudo docker-compose build --pull
sudo docker-compose up -d --remove-orphans

# Print status
sudo docker-compose ps

echo "\nChatbot stack is up and running!"

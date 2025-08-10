#!/bin/bash
set -e

# Update system and install Docker & Docker Compose
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y docker.io docker-compose
sudo systemctl enable --now docker
export COMPOSE_HTTP_TIMEOUT=300

# Clone or update the repo
if [ ! -d "chatbot" ]; then
  git clone https://github.com/prabhat-roy/devops-chatbot.git chatbot
else
  cd chatbot && git pull && cd ..
fi

cd chatbot

# Build and start containers
sudo -E docker-compose pull
sudo -E docker-compose build --pull
sudo -E docker-compose up -d --remove-orphans

# Print status
sudo docker-compose ps

echo "\nChatbot stack is up and running!"

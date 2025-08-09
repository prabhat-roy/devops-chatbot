#!/bin/sh
set -e

# Start Ollama server in the background
ollama serve &
OLLAMA_PID=$!

# Wait for server to be ready
echo "Waiting for Ollama to start..."
sleep 5

# Pull models
echo "Pulling models..."
ollama pull llama3:8b
ollama pull codellama:13b

# Wait for Ollama server process
wait $OLLAMA_PID

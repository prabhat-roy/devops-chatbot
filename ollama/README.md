# Ollama Model Service

This container will serve both llama3:8b (reasoning) and codellama:13b (code generation) models. The backend should specify the model in the API call as needed.

- llama3:8b for reasoning
- codellama:13b for code generation

Models are pre-pulled at build time for faster startup.

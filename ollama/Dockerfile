# Ollama Dockerfile for Llama3:8b and CodeLlama:13b
FROM ollama/ollama:latest

# Download models at build time for faster startup
RUN ollama pull llama3:8b && ollama pull codellama:13b

EXPOSE 11434
CMD ["ollama", "serve"]

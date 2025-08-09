# Ollama Dockerfile for Llama3:8b and CodeLlama:13b
FROM ollama/ollama:latest

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


EXPOSE 11434
ENTRYPOINT ["/entrypoint.sh"]

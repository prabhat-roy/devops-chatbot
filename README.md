# DevOps Chatbot (Ollama, FastAPI, React)

A full-stack, containerized chatbot for DevOps and code generation tasks, using local LLMs (llama3:8b for reasoning, codellama:13b for code) via Ollama.

## Features
- Chat UI with real-time streaming responses
- Code and project generation, review, and DevOps automation
- Multi-model support (reasoning and code)
- Modern React frontend (Vite + Nginx)
- FastAPI backend
- Ollama model server (llama3:8b, codellama:13b)
- Secure, multi-stage Docker builds
- One-command install/update script for new servers

## Quick Start

### 1. Prerequisites
- Linux server (x86_64, with Docker and Docker Compose)
- At least 32GB RAM recommended for large models

### 2. Install & Deploy
1. Clone this repo to your server
2. Edit `install_and_update.sh` and set your repo URL if needed
3. Run:
	```bash
	chmod +x install_and_update.sh
	./install_and_update.sh
	```
4. Access the chatbot at `http://<server-ip>/`

### 3. Project Structure
- `backend/` — FastAPI backend (Python)
- `frontend/` — React frontend (Vite + Nginx)
- `ollama/` — Ollama model server Dockerfile
- `docker-compose.yml` — Orchestrates all services
- `install_and_update.sh` — Automated install/update script

### 4. Model Usage
- Reasoning: llama3:8b
- Code generation: codellama:13b
- The backend selects the model in API calls as needed

### 5. Security & Best Practices
- Non-root containers, minimal images
- No secrets in repo; use `.env` for sensitive config
- Models and data are stored in Docker volumes, not in the repo

---

For more, see each service's README and Dockerfile. Replace placeholders as you customize.

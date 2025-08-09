
from fastapi import FastAPI, Request
from fastapi.responses import StreamingResponse
from fastapi.middleware.cors import CORSMiddleware
import httpx
import os
import json

app = FastAPI()

# Allow frontend dev server
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

OLLAMA_URL = os.getenv("OLLAMA_URL", "http://localhost:11434")

@app.post("/api/generate")
async def generate_code(request: Request):
    data = await request.json()
    prompt = data.get("prompt", "")
    model = data.get("model", "llama3:8b")
    async def event_stream():
        async with httpx.AsyncClient() as client:
            response = await client.post(
                f"{OLLAMA_URL}/api/generate",
                json={"model": model, "prompt": prompt},
                timeout=120
            )
            async for line in response.aiter_lines():
                if line.strip():
                    try:
                        data = json.loads(line)
                        chunk = data.get("response", "")
                        if chunk:
                            yield chunk
                    except Exception:
                        pass
    return StreamingResponse(event_stream(), media_type="text/plain")

@app.post("/api/review")
async def review_code(request: Request):
    data = await request.json()
    code = data.get("code", "")
    model = data.get("model", "llama3:8b")
    prompt = f"Review this code:\n{code}"
    async def event_stream():
        async with httpx.AsyncClient() as client:
            response = await client.post(
                f"{OLLAMA_URL}/api/generate",
                json={"model": model, "prompt": prompt},
                timeout=120
            )
            async for line in response.aiter_lines():
                if line.strip():
                    try:
                        data = json.loads(line)
                        chunk = data.get("response", "")
                        if chunk:
                            yield chunk
                    except Exception:
                        pass
    return StreamingResponse(event_stream(), media_type="text/plain")

@app.post("/api/create-file")
async def create_file(request: Request):
    data = await request.json()
    path = data.get("path")
    content = data.get("content", "")
    if not path:
        return {"error": "Path required"}
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
    return {"status": "ok"}

@app.post("/api/create-project")
async def create_project(request: Request):
    data = await request.json()
    name = data.get("name")
    if not name:
        return {"error": "Project name required"}
    os.makedirs(name, exist_ok=True)
    return {"status": "created", "project": name}

@app.post("/api/vscode-command")
async def vscode_command(request: Request):
    data = await request.json()
    command = data.get("command")
    # Placeholder: implement VS Code integration logic
    return {"status": "received", "command": command}

@app.get("/")
def root():
    return {"status": "DevOps Chatbot Backend Running"}

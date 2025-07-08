FROM nvcr.io/nvidia/pytorch:23.12-py3

COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Set the default command to run the vLLM OpenAI server
CMD ["python3", "-m", "vllm.entrypoints.openai.api_server", \
     "--model", "meta-llama/Llama-2-7b-chat-hf", \
     "--port", "8001"]

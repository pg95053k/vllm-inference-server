FROM nvcr.io/nvidia/pytorch:23.12-py3

RUN pip install --upgrade pip && \
    pip install vllm

# Set the default command to run the vLLM OpenAI server
CMD ["python3", "-m", "vllm.entrypoints.openai.api_server", \
     "--model", "meta-llama/Llama-2-7b-chat-hf", \
     "--port", "8000"]

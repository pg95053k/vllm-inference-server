curl http://narmada.merai.cloud:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "meta-llama/Llama-2-7b-chat-hf",
    "messages": [{"role": "user", "content": "Your prompt here"}],
    "temperature": 0.7,
    "max_tokens": 100
  }'
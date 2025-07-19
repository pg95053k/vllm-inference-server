# 🚀 Deploying `vLLM` with OpenAI-Compatible API

This guide outlines how to pull the latest `vLLM` OpenAI-compatible Docker image, deploy it with GPU support on Linux, and test it using `curl`.

---

## 🔄 Get latest `vLLM` OpenAI Docker image

```bash
docker pull vllm/vllm-openai:latest
```

---

## 🐳 Deploy with Docker on Linux

```bash
nohup docker run --runtime=nvidia \
  --gpus '"device=2,3"' \
  --name deepseek_int8_tp2 \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  --env "HUGGING_FACE_HUB_TOKEN=<secret>" \
  -p 8010:8000 \
  --ipc=host \
  vllm/vllm-openai:latest \
  --model neuralmagic/DeepSeek-R1-Distill-Llama-70B-quantized.w8a8 \
  --tensor-parallel-size 2 \
  --max-model-len 32768 > deepseek.log 2>&1 &
```

> 📌 **Note**:
>
> * Replace `<secret>` with your actual Hugging Face token.
> * Adjust `--gpus` and `--max-model-len` based on your hardware.

---

## 🧪 Call the server using `curl`

```bash
curl http://<username>:8010/v1/chat/completions \
  -X POST -H "Content-Type: application/json" \
  -d '{
    "model": "neuralmagic/DeepSeek-R1-Distill-Llama-70B-quantized.w8a8",
    "messages": [{"role": "user", "content": "Who are you?"}]
  }'
```

> ✅ This tests the OpenAI-compatible `/v1/chat/completions` endpoint.

---

## 🛠️ Use with ChatOpenAI from LangChain

```python
from langchain_openai import ChatOpenAI
llm = return ChatOpenAI(
    model="neuralmagic/DeepSeek-R1-Distill-Llama-70B-quantized.w8a8",
    openai_api_key="EMPTY",
    openai_api_base="http://narmada.merai.cloud:8010/v1",
    temperature=0,
)
```

---

## 📂 Logs

Logs are written to `deepseek.log`:

```bash
tail -f deepseek.log
```

---
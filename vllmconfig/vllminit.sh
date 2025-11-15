#!/bin/bash

source .env

# Set Variables
PORT=8000
SERVED_MODEL_NAME="Qwen3-0.6B"
GPU_MEMORY_UTILIZATION=0.9
LOG_FILE="/home/shared/vllm-logs/vllm.log"
MAX_SEQS=256 # This defines how many requests the inference server can process at once
dtype=half

# Run the docker container with our configuration
sudo docker run --runtime nvidia --gpus all \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  --env "HUGGING_FACE_HUB_TOKEN=$HF_TOKEN" \
  -p $PORT:8000 \
  --ipc=host \
  vllm/vllm-openai:latest \
  --model $MODEL \
  --trust-remote-code \
  --host 0.0.0.0 \
  --served-model-name $SERVED_MODEL_NAME \
  --swap-space 0 \
  --dtype $dtype \
  --gpu-memory-utilization $GPU_MEMORY_UTILIZATION \
  --max-num-seqs $MAX_SEQS \
  2>&1 | tee "$LOG_FILE"

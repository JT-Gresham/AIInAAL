#!/usr/bin/env bash

source /etc/AIInAAL/AIInAAL_path
source /home/LACII14/Archive-M1/AI/AIInAAL/libref
source /home/LACII14/Archive-M1/AI/AIInAAL/Ollama/libref-Ollama
source /home/LACII14/Archive-M1/AI/AIInAAL/AIInAAL_env/bin/activate
AIInAAL_update
#export OLLAMA_DEBUG=1
#export OLLAMA_USE_OPENVINO=true
#export OLLAMA_USE_DEVICE=0
#export OLLAMA_DISABLE_CPU=1
export OLLAMA_INTEL_GPU=true
export OLLAMA_NUM_GPU=999
export OLLAMA_NUM_GPU_LAYERS=9999
export TORCH_DEVICE_BACKEND_AUTOLOAD=0
source ipex-llm-init -g --device Arc
AIInAAL_update_Ollama
cd $AIInAALdir/AIInAAL_env/lib/python3.11/site-packages/ollama
./start-ollama.sh &

Ollama_exit

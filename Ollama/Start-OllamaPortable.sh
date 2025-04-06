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
export OLLAMA_KEEP_ALIVE=-1
#export OLLAMA_NUM_PARALLEL=4
#export OLLAMA_MAX_LOADED_MODELS=1
export OLLAMA_INTEL_GPU=true
export OLLAMA_NUM_GPU=9999
export OLLAMA_NUM_GPU_LAYERS=9999
export TORCH_DEVICE_BACKEND_AUTOLOAD=0
source ipex-llm-init -g --device Arc
AIInAAL_update_Ollama
cd $AIInAALdir/AIInAAL_env/lib/python3.11/site-packages/ollama
clear
echo "##### AIInAAL OLLAMA PORTABLE #####"
echo ""
echo "To use the Ollama Portable Server...you'll need to open a new terminal and activate the environment to function as your chat interface."
echo "In the new terminal: cd into your AIInAAL directory, then use this command: source AIInAAL_env/bin/activate"
echo "You should now see your prompt line start with (AIInAAL_env)"
echo "Wait for the Ollama server to start in this terminal, then load your ollama LLM (in the chat terminal) with: ollama run <LLM name>"
echo ""
echo "Press a key to start the ollama server..."
read go
./start-ollama.sh
Ollama_exit

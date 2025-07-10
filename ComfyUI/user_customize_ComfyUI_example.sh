#!/usr/bin/env bash
source AIInAAL/libref
####  This file is for you to add any code you want to execute just before ComfyUI launches.  This will not be updated when AIInAAL or ComfyUI updates.
####  This is useful if you want to create custom presets and make sure your code, links, etc gets put back after an official update from the ComfyUI team.
####  I'll include the code I wrote to load my own custom preset as an example.  I didn't wnat to do this every time the ComfyUI team updated...

####  THIS CODE STARTS IN YOUR PARENT DIRECTORY
####    eg: where the AIInAAL directory is located

#### EXAMPLE CODE ####

#  Change directory to make things easier
#cd $pdirectory/AIInAAL

#  Copy files (without overwritting) from my custom preset directory (ComfyUI_Presets) I created in the AIInAAL shared folder
#cp --no-clobber -R shared/presets/ComfyUI/* ComfyUI/presets/

#  Change into the ComfyUI directory for the next part.
#cd ComfyUI/modules

#   If you already have Fooocus installed in AIInAAL then uncomment the below to tie in your custom styles and wildcards
#rm -r $pdirectory/AIInAAL/ComfyUI/custom_nodes/Fooocus_Nodes/sdxl_styles
#rm -r $pdirectory/AIInAAL/ComfyUI/custom_nodes/Fooocus_Nodes/wildcards
#ln -sf $pdirectory/shared/sdxl_styles/Fooocus/ $pdirectory/AIInAAL/ComfyUI/custom_nodes/Fooocus_Nodes/sdxl_styles
#ln -sf $pdirectory/shared/wildcards/ $pdirectory/AIInAAL/ComfyUI/custom_nodes/Fooocus_Nodes/wildcards

# If you already have OmniGen installed in AIInAAL then uncomment the code below and install the OmniGen-ComfyUI by AFISH custom nodes in ComfyUI. This will tie in your existing installation. Make sure to get the right one since there's several packages available.
#rm -r $pdirectory/AIInAAL/ComfyUI/custom_nodes/OmniGen-ComfyUI/OmniGen
#ln -sf $pdirectory/AIInAAL/OmniGen/OmniGen/ $pdirectory/AIInAAL/ComfyUI/custom_nodes/OmniGen-ComfyUI/OmniGen
#### MODEL SPECIFIC - I have renamed my OmniGen model to OmniGen-v1.safetensors...you must change the name in the link below to match yours.
#ln -sf $pdirectory/AIInAAL/shared/LLMs/OmniGen/OmniGen-v1.safetensors $pdirectory/AIInAAL/ComfyUI/models/OmniGen/OmniGen-v1/model.safetensors

#### Creates a new output folder with today's date
#cd $pdirectory/AIInAAL/ComfyUI
#outputdir=$(echo $(date +%Y)"-"$(date +%m)"-"$(date +%d))
#mkdir -p "output/Remote/"$outputdir

# Clears the persistent input cache directory of any used uploaded images *privacy protection* - Done before the ComfyUI launches
#cd $pdirectory/AIInAAL
#cp ComfyUI/input/example.png /tmp/
#rm -r ComfyUI/input
#mkdir -p ComfyUI/input/3d
#cp /tmp/example.png ComfyUI/input/

# Tie RoopUL models to ComfyUI for the ComfyUI-FaceSwap package
#cd $pdirectory/AIInAAL
#rm -r $pdirectory/AIInAAL/ComfyUI/models/roop
#ln -sf $pdirectory/AIInAAL/shared/RoopUL/models/ $pdirectory/AIInAAL/ComfyUI/models/roop

# Fixes for ComfyUI-roop-node (not comfyui-roop) SEE: https://codeberg.org/Gourieff/comfyui-reactor-node
#pip install --upgrade albumentations==1.14.16 #fixes albucore requirement so nodes will load (Also allows ComfyUI-FaceSwap to load)
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

#  Since my name is both capital letters, I need to make a change into a ComfyUI file so it will recognize my name as "JT" ...not "Jt" (only if needed)
#    Coding note: The \x27 that you see everywhere is an ASCII escape...necessary for sed to process strings with single quotes in them.

#  if grep -Fxq "k = k.replace('Jt', 'JT')" sdxl_styles.py
#    then
#      echo "JT correction entry found in sdxl_styles.py...skipping"
#    else
#      sed -i 's|k = k.replace(\x27(s\x27, \x27(S\x27)|k = k.replace(\x27(s\x27, \x27(S\x27)\n    k = k.replace(\x27Jt\x27, \x27JT\x27)|g' sdxl_styles.py
#  fi

#  Lastly, I want ComfyUI to make sure to add my styles only if needed...the 'if' statement makes sure there isn't duplicate lines of code added. 
#  if grep -Fxq "sdxl_styles_JT.json" sdxl_styles.py
#    then
#      echo "JT styles entry found in sdxl_styles.py...skipping"
#    else
#      sed -i 's|\x27sdxl_styles_sai.json\x27,|\x27sdxl_styles_sai.json\x27,\n          \x27sdxl_styles_JT.json\x27,|g' sdxl_styles.py
#  fi

#!/usr/bin/env bash

source /etc/AIInAAL/AIInAAL_path
aiinaalpkg=Auto1111
####  This file is for you to add any code you want to execute just before Auto1111 launches.  This will not be updated when AIInAAL or Auto1111 updates.
####  This is useful if you want to create custom presets and make sure your code, links, etc gets put back after an official update from the Auto1111 team.
####  I'll include the code I wrote to load my own custom preset as an example.  I didn't wnat to do this every time the Auto1111 team updated...

####  THIS CODE STARTS IN YOUR PARENT DIRECTORY
####    eg: where the AIInAAL directory is located

#### EXAMPLE CODE ####

# This links Auto1111 to the shared wildcards directory. Enable this after installing the stable-diffusion-webui-wildcards extension.
#  NOTE: I recommend installing the sd-dynamic-prompts extension as well (necessary for nested wildcards)
#rm -rf "$AIInAALdir/$aiinaalpkg/extensions/stable-diffusion-webui-wildcards/wildcards"
#ln -sf "$AIInAALdir/shared/wildcards/Fooocus/" "$AIInAALdir/$aiinaalpkg/extensions/sd-dynamic-prompts/wildcards"

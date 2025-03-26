#!/usr/bin/env bash

source /etc/AIInAAL/AIInAAL_path

source $AIInAALdir/AIInAAL_env/bin/activate
cd $AIInAALdir/Scripts/AIInAAL_Browser

python main.py "$@"

#!/usr/bin/env bash

source /etc/AIInAAL/AIInAAL_path
source $AIInAALdir/libref
source $AIInAALdir/AIInAAL_env/bin/activate

cd $AIInAALdir/AIInAAL_env/lib/python3.11/site-packages
git clone --recursive https://github.com/vosen/ZLUDA.git



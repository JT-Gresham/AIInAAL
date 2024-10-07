#!/usr/bin/env bash
source /etc/AIInAAL/AIInAAL_path
source $AIInAALdir/libref
source $AIInAALdir/AIInAAL_env/bin/activate

curl -sSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
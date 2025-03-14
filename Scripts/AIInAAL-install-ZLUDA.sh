#!/usr/bin/env bash

source /etc/AIInAAL/AIInAAL_path
source $AIInAALdir/libref
source $AIInAALdir/AIInAAL_env/bin/activate

sudo pacman -S --needed cargo-run-bin cargo-release
cd $AIInAALdir/AIInAAL_env/lib/python3.11/site-packages
git clone --recursive https://github.com/vosen/ZLUDA.git
cd ZLUDA
cargo xtask --release



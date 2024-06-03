#!/usr/bin/env bash

echo "Installation of the AIInAAL framework"
echo "What directory do you want the AIInAAL framework to be installed in?"
echo "- Enter the FULL PATH below. Do NOT include the \"/\" at the very end."
read pdirectory
echo "Downloading AIInAAL..."
cd $pdirectory
git clone "http://github.com/JT-Gresham/AIInAAL"
#Run after git pull
sed -i 's|ParentDirectory|\x24pdirectory|g' AIInAAL/libref
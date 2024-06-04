#!/usr/bin/env bash

echo "########## AI Framework for Intel Arc GPUs on Arch Linux ##########"
echo "################### created by JT Gresham ####################"
echo ""
echo "*  This installer requires that you have up-to-date drivers for your Intel Arc GPU."
echo "*  You also need to have Python 3.11 installed since this installer creates your"
echo "       python virtual environment with it. It can be found in the AUR (python311)"
echo "*  This installer will check/install a couple of packages via PACMAN. These are installed"
echo "       from the offical Arch repositories so you will be asked to authorize the install with"
echo "       your password."
echo "*  Installing this framework will provide a more efficient installation of popular AI packages."
echo "   This installation will create custom launchers by using the information you enter here."
echo ""
echo "Press enter to continue the installation..."
read go
echo "AIInAAL installer needs to check/install some PACMAN packages...Please authorize to continue..."
sudo pacman -S --needed intel-compute-runtime intel-graphics-compiler ocl-icd opencl-headers 
echo ""
echo "--- Important Notes:"
echo "   * This directory can get pretty big in size as you add AI Software, LLMs, Checkpoints...etc!"
echo "   * Make sure you've got storage space to accomodate your future needs!"
echo "   * To avoid potential issues, the FULL PATH should not contain any spaces or special characters."
echo ""
echo "What is the FULL PATH of directory where you want to install \"AIInAAL\"?"
echo "---IMPORTANT: Exclude the trailing \"/\"---"
read pdirectory
echo ""
echo "Your installation will be installed in $pdirectory/AIInAAL"
echo ""
echo "Changing directory -> $pdirectory"
cd $pdirectory
echo ""
git clone https://github.com/JT-Gresham/AIInAAL.git
echo ""
echo "Changing directory ->$pdirectory/AIInAAL"
cd $pdirectory/AIInAAL
echo ""
echo "Creating python 3.11 environment (AIInAAL_env)"
/usr/bin/python3.11 -m venv AIInAAL_env
echo ""
echo "Activating environment -> AIInAAL_env"
source AIInAAL_env/bin/activate
echo ""
echo "Installing wheel package..."
pip install wheel
echo ""
echo "Installing packages from requirements_AIInAAL.txt..."
pip install -r requirements_AIInAAL.txt
#Run after git pull
touch $pdirectory/AIInAAL/Scripts/AIInAAL.path
echo "pdirectory=$pdirectory" > $pdirectory/AIInAAL/Scripts/AIInAAL.path
echo "AIInAALdir=$pdirectory/AIInAAL" >> $pdirectory/AIInAAL/Scripts/AIInAAL.path
./Scripts/librefgen

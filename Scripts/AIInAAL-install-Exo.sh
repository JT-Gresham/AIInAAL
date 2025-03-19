#!/usr/bin/env bash
source /etc/AIInAAL/AIInAAL_path
AIInAALuser="$(whoami)"

echo "##### AIInAAL installation of EXO #####"
cd $AIInAALdir
echo ""
if [ ! -d "$pdirectory/AIInAAL/AIInAAL12_env" ]; then
echo "Creating python 3.12 environment (AIInAAL12_env)"
/usr/bin/python3.12 -m venv $pdirectory/AIInAAL/AIInAAL12_env
echo ""
echo "Activating environment -> AIInAAL12_env"
source $pdirectory/AIInAAL/AIInAAL12_env/bin/activate
echo "AIInAAL installer needs to check/install some PACMAN packages...Please authorize to continue..."
sudo pacman -S --needed intel-compute-runtime intel-graphics-compiler ocl-icd opencl-headers level-zero-loader python-pipx lm_sensors
echo "Installing pip..."
cd $pdirectory/AIInAAL/Scripts
python get-pip.py
cd $pdirectory/AIInAAL
echo ""
echo "Installing wheel package..."
pip install wheel
fi
ln -sf $pdirectory/AIInAAL/Scripts/ipex-llm-init $pdirectory/AIInAAL/AIInAAL12_env/bin/
#ln -sf $pdirectory/AIInAAL/Scripts/ipex-llm-init $pdirectory/AIInAAL/AIInAAL12_env_inf/bin/
echo ""
echo "Initializing the AIInAAL and Deb4AIInAAL(12) commands."
#ln -sf $pdirectory/AIInAAL/Scripts/AIInAAL $pdirectory/AIInAAL/AIInAAL12_env/bin/AIInAAL
ln -sf $pdirectory/AIInAAL/Scripts/Deb4AIInAAL12 $pdirectory/AIInAAL/AIInAAL12_env/bin/Deb4AIInAAL12
#sudo ln -sf $pdirectory/AIInAAL/AIInAAL12_env/bin/AIInAAL /bin/AIInAAL
sudo ln -sf $pdirectory/AIInAAL/AIInAAL12_env/bin/Deb4AIInAAL12 /bin/Deb4AIInAAL12
#sudo chmod +x /bin/AIInAAL
sudo chmod +x $pdirectory/AIInAAL/AIInAAL12_env/bin/AIInAAL
sudo chmod +x $pdirectory/AIInAAL/AIInAAL12_env/bin/Deb4AIInAAL12
echo "Creating initial \"shared\" directory...replace with yours afterward, if necssary (symlink allowed)"
if [ ! -d "$pdirectory/AIInAAL/shared" ]; then
  mv ./shared1 ./shared
fi
cd $tmp
git clone https://github.com/exo-explore/exo.git /tmp/Exo
cp -rf /tmp/Exo/.* /home/LACII14/Archive-M1/AI/AIInAAL/Exo/
cp -rf /tmp/Exo/* /home/LACII14/Archive-M1/AI/AIInAAL/Exo/
rm -r /tmp/Exo
cd $AIInAALdir/Exo
pip install -e .
echo "AIInAAL framework is now installed. AI program installers are located in the \"Scripts\" directory."
echo "AIInAAL is updated \(if necessary\) whenever a framework program is started, however..."
echo "   you can also use the command: \"AIInAAL-update\" in your terminal to update AIInAAL whenever you wish."
echo ""
echo "Thank you for trying out AIInAAL...this is a lot of work."
echo ""
echo "Before you press a key to exit the installer, a small request:"
echo "   I'd appreciate it if you'd consider supporting my work by using one of the methods listed on the main github page. - OCD"
read go
#Run after git pull

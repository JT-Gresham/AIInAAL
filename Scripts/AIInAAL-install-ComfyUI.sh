#!/usr/bin/env bash

source /etc/AIInAAL/AIInAAL_path
source $AIInAALdir/libref
source $AIInAALdir/AIInAAL_env/bin/activate
aiinaalpkg="ComfyUI"
aiinaalpkgURL="https://github.com/comfyanonymous//$aiinaalpkg.git"

echo "########## $aiinaalpkg for Intel Arc GPUs on Arch Linux ##########"
echo "##################### framework by JT Gresham #####################"
echo ""
echo "*     This installer requires that you have up-to-date drivers for your Intel Arc GPU."
echo "*     This installer requires that you have the AIInAAL already installed."
echo "*     This installer will create a customized start script by using the information you enter."
echo ""
echo "Press enter to continue the installation..."
read go
echo "Your installation will be installed in $AIInAALdir/$aiinaalpkg"
echo ""
AIInAAL_update
echo "Changing directory ->$AIInAALdir/$aiinaalpkg"
cd $AIInAALdir/$aiinaalpkg
echo ""
echo "Cloning official $aiinaalpkg repository to $aiinaalpkg"

#### GIT CLONE COMMAND  URL HERE ####
git clone "$aiinaalpkgURL" "/tmp/$aiinaalpkg"
mv -f "/tmp/$aiinaalpkg/.git" "$AIInAALdir/$aiinaalpkg/"
mv -f "/tmp/$aiinaalpkg/sdxl_styles/"* "$AIInAALdir/shared1/sdxl_styles/"
cd $AIInAALdir/$aiinaalpkg
git checkout .
rm -r /tmp/$aiinaalpkg
source $AIInAALdir/$aiinaalpkg/libref-$aiinaalpkg
echo ""
echo "Applying AIInAAL modifications to original $aiinaalpkg..."
AIInAAL_update_$aiinaalpkg
cp $AIInAALdir/$aiinaalpkg/user_customize_$aiinaalpkg_example.sh $AIInAALdir/$aiinaalpkg/user_customize_$aiinaalpkg.sh
echo ""
echo "Installing packages from requirements.txt..."
cd $AIInAALdir/$aiinaalpkg
sleep 1
AIInAAL update Torch
pip install -r requirements.txt
pip install -r requirements_$aiinaalpkg.txt
AIInAAL update Intel
echo ""
echo "Creating the launcher file ($aiinaalpkg-Start.sh)"
cp "user_customize_"$aiinaalpkg"_example.sh" "user_customize_"$aiinaalpkg".sh"
#mkdir ./custom_nodes
cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager comfyui-manager
#git clone https://github.com/Seedsa/Fooocus_Nodes.git Fooocus_Nodes
cd ..
touch $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "#!/usr/bin/env bash" > $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "source /etc/AIInAAL/AIInAAL_path" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "source $AIInAALdir/libref" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "source $AIInAALdir/$aiinaalpkg/libref-$aiinaalpkg" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "source $AIInAALdir/AIInAAL_env/bin/activate" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "AIInAAL_update" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh

#### Executable below
echo "source ipex-llm-init -g --device Arc" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "AIInAAL_update_$aiinaalpkg" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "export TORCH_DEVICE_BACKEND_AUTOLOAD=0" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "python $AIInAALdir/$aiinaalpkg/main.py --port 7865 \"\$@\"" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "sleep 60"
#echo "echo "ComfyUI is still running in the background. Enter command: ComfyUI-exit to close down ComfyUI.""
#echo "" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "Setting the new start file to be executable. (Authorization Required)"
sudo chmod +x $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "Creating executable link in /usr/bin --> AIInAAL-$aiinaalpkg"
sudo ln -sf "$AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh" "/usr/bin/AIInAAL-$aiinaalpkg"
echo "Installation complete. Start with command: AIInAAL-$aiinaalpkg with any ComfyUI arguments afterward"
echo "--Press any key to exit installer--"
read go
exit 0

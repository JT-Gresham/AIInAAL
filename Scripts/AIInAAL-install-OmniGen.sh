#!/usr/bin/env bash

source /etc/AIInAAL/AIInAAL_path
source $AIInAALdir/libref
source $AIInAALdir/AIInAAL_env/bin/activate
aiinaalpkg="OmniGen"
aiinaalpkgURL="https://github.com/newgenai79/OmniGen.git"

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
echo "Installing packages from requirements_versions.txt..."
cd $AIInAALdir/$aiinaalpkg
sleep 1
#pip install -r requirements_versions.txt
pip install -r requirements_$aiinaalpkg.txt
echo ""
echo "Creating the launcher file ($aiinaalpkg-Start.sh)"
cp user_customize_$aiinaalpkg_example.sh user_customize_$aiinaalpkg.sh
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
echo "python $AIInAALdir/$aiinaalpkg/app.py \"\$@\"" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "sleep 5"
#echo "echo "OmniGen is still running in the background. Enter command: OmniGen-exit to close down OmniGen.""
#echo "" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "Setting the new start file to be executable. (Authorization Required)"
sudo chmod +x $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "Creating executable link in /usr/bin --> AIInAAL-$aiinaalpkg"
sudo ln -sf "$AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh" "/usr/bin/AIInAAL-$aiinaalpkg"
echo "Installation complete. Start with command: AIInAAL-$aiinaalpkg with any OmniGen arguments afterward"
echo "--Press any key to exit installer--"
read go
exit 0

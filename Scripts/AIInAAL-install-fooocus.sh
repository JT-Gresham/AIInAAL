#!/usr/bin/env bash

source /etc/AIInAAL/AIInAAL_path
source $AIInAALdir/libref
source $AIInAALdir/AIInAAL_env/bin/activate
aiinaalpkg="fooocus"

echo "########## $AIInAALpkg for Intel Arc GPUs on Arch Linux ##########"
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
echo "Changing directory ->$AIInAALdir/$aiinaalpkg"
cd $AIInAALdir/$aiinaalpkg
echo ""
echo "Cloning official $AIInAALpkg repository to $aiinaalpkg"

#### GIT CLONE COMMAND  URL HERE ####
git clone "https://github.com/lllyasviel/$AIInAALpkg.git" "/tmp/$aiinaalpkg"
mv -f "/tmp/$aiinaalpkg/.git" "$AIInAALdir/$aiinaalpkg/"
git checkout .
rm -r /tmp/$aiinaalpkg
source $AIInAALdir/$aiinaalpkg/libref-$AIInAALpkg
echo ""
echo "Applying AIInAAL modifications to original $AIInAALpkg..."
AIInAAL_update_$AIInAALpkg
echo ""
echo "Installing packages from requirements_versions.txt..."
cd $AIInAALdir/$aiinaalpkg
sleep 1
pip install -r requirements_versions.txt
echo ""
echo "Creating the launcher file ($AIInAALpkg-Start.sh)"
cp user_customize_fooocus_example.sh user_customize_fooocus.sh
touch $AIInAALdir/$aiinaalpkg/$AIInAALpkg-Start.sh
echo "#!/usr/bin/env bash" > $AIInAALdir/$aiinaalpkg/$AIInAALpkg-Start.sh
echo "" >> $AIInAALdir/$aiinaalpkg/$AIInAALpkg-Start.sh
echo "source /etc/AIInAAL/AIInAAL_path" >> $AIInAALdir/$aiinaalpkg/$AIInAALpkg-Start.sh
echo "source $AIInAALdir/libref" >> $AIInAALdir/$aiinaalpkg/$AIInAALpkg-Start.sh
echo "source $AIInAALdir/$aiinaalpkg/libref-$AIInAALpkg" >> $AIInAALdir/$aiinaalpkg/$AIInAALpkg-Start.sh
echo "source $AIInAALdir/AIInAAL_env/bin/activate" >> $AIInAALdir/$aiinaalpkg/$AIInAALpkg-Start.sh
echo "AIInAAL_update" >> $AIInAALdir/$aiinaalpkg/$AIInAALpkg-Start.sh

#### Executable below
echo "AIInAAL_update_$AIInAALpkg" >> $AIInAALdir/$aiinaalpkg/$AIInAALpkg-Start.sh
echo "python $AIInAALdir/$aiinaalpkg/launch.py --port 7865 \"\$@\"" >> $AIInAALdir/$aiinaalpkg/$AIInAALpkg-Start.sh
echo "sleep 60"
echo "echo "Fooocus is still running in the background. Enter command: fooocus-exit to close down fooocus.""
echo "" >> $AIInAALdir/$aiinaalpkg/$AIInAALpkg-Start.sh
echo "Setting the new start file to be executable. (Authorization Required)"
sudo chmod +x $AIInAALdir/$aiinaalpkg/$AIInAALpkg-Start.sh
echo "Creating executable link in /usr/bin --> AIInAAL-$AIInAALpkg"
sudo ln -sf "$AIInAALdir/$aiinaalpkg/$AIInAALpkg-Start.sh" "/usr/bin/AIInAAL-$AIInAALpkg"
echo "Installation complete. Start with command: AIInAAL-$AIInAALpkg with any fooocus arguments afterward"
echo "--Press any key to exit installer--"
read go
exit 0

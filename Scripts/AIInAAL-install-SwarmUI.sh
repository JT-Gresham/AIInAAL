#!/usr/bin/env bash

source /etc/AIInAAL/AIInAAL_path
source $AIInAALdir/libref
source $AIInAALdir/AIInAAL_env/bin/activate
aiinaalpkg="SwarmUI"
aiinaalpkgURL="https://github.com/mcmonkeyprojects//$aiinaalpkg.git"

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
mv -rf "/tmp/$aiinaalpkg/sdxl_styles/"* "$AIInAALdir/shared1/sdxl_styles/"
cd $AIInAALdir/$aiinaalpkg
git checkout .
mkdir "$AIInAALdir/$aiinaalpkg/models"
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
ln -sf "$AIInAALdir/AIInAAL_env/lib/python3.11/dotnetcore2/bin/dotnet" "$AIInAALdir/AIInAAL_env/bin/dotnet"
cd launchtools
rm dotnet-install.sh
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x dotnet-install.sh
cd ..
SCRIPT_DIR=$(echo $AIInAALdir/$aiinaalpkg)
DOTNET_ROOT=$AIInAALdir/AIInAAL_env/lib/python3.11/dotnetcore2/bin/dotnet
export PATH="$AIInAALdir/AIInAAL_env/lib/python3.11/dotnetcore2/bin/dotnet:$PATH"
# Note: manual installers that want to avoid home dir, add to both of the below lines: --install-dir "$AIInAALdir/$aiinaalpkg/.dotnet"
./launchtools/dotnet-install.sh --channel 8.0 --runtime aspnetcore --install-dir "$AIInAALdir/$aiinaalpkg/.dotnet"
./launchtools/dotnet-install.sh --channel 8.0 --install-dir "$AIInAALdir/$aiinaalpkg/.dotnet"
cd $SCRIPT_DIR
$SCRIPT_DIR/.dotnet/dotnet build src/SwarmUI.csproj --configuration Release -o ./src/bin/live_release
cur_head=`git rev-parse HEAD`
echo $cur_head > src/bin/last_build
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
echo "#source ipex-llm-init -g --device Arc" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "AIInAAL_update_$aiinaalpkg" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "cd $AIInAALdir/$aiinaalpkg" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "$AIInAALdir/$aiinaalpkg/launch-linux.sh \"\$@\"" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
#echo "sleep 60"
#echo "echo "SwarmUI is still running in the background. Enter command: SwarmUI-exit to close down SwarmUI.""
#echo "" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "Setting the new start file to be executable. (Authorization Required)"
sudo chmod +x $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "Creating executable link in /usr/bin --> AIInAAL-$aiinaalpkg"
sudo ln -sf "$AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh" "/usr/bin/AIInAAL-$aiinaalpkg"
mkdir "$AIInAALdir/$aiinaalpkg/src/bin"
touch "$AIInAALdir/$aiinaalpkg/src/bin/last_build"
if grep -Fxq "https://download.pytorch.org/whl/xpu" $AIInAALdir/$aiinaalpkg/launchtools/comfy-install-linux.sh
    then
        echo "JT correction entry found in comfy-install-linux.sh ...skipping"
    else
        sed -i 's|GPU_TYPE=$1|GPU_TYPE=xpu|g' $AIInAALdir/$aiinaalpkg/launchtools/comfy-install-linux.sh
        sed -i 's|&& [ "$GPU_TYPE" != "nv" ]|&& [ "$GPU_TYPE" != "nv" ] && [ "$GPU_TYPE" != "xpu" ]|g' $AIInAALdir/$aiinaalpkg/launchtools/comfy-install-linux.sh
        sed -i 's|--index-url https://download.pytorch.org/whl/nightly/rocm7.1|--index-url https://download.pytorch.org/whl/nightly/rocm7.1\nelif [ "$GPU_TYPE" == "xpu" ]; then\n    echo "install xpu torch..."\n    $python -s -m pip install --pre torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/xpu|g' $AIInAALdir/$aiinaalpkg/launchtools/comfy-install-linux.sh
fi
echo "Installation complete. Start with command: AIInAAL-$aiinaalpkg with any SwarmUI arguments afterward"
echo "     IMPORTANT: To use SwarmUI with the ComfyUI backend if already installed in AIInAAL:"
echo "          1.) You need to tell SwarmUI you have a pre-existing installation...so make that choice upon first startup"
echo "          2.) If you've already downloaded models, you won't need to install any...not even the base one so deselect all of them"
echo "          3.) Once you can get to the server settings, you need to set the ComfyUI backend launcher to your ComfyUI-Start.sh file in your AIInAAL/ComfyUI directory.  The easiest way is to copy the file address in your file browser and then paste it into you launcher entry."
echo "That's it...SwarmUI should launch and autostart your ComfyUI installation. It may complain because it's looking for main.py...but pay no attention to that warning.  Your AIInAAL launcher will handle that after the settings/mods are handled."
echo "##### DON'T set it to the main.py file it's asking for...seriously...doing that can mess stuff up. #####"
echo "--Press any key to exit installer--"
read go
exit 0

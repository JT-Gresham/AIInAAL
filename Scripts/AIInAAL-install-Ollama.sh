#!/usr/bin/env bash

source /etc/AIInAAL/AIInAAL_path
source $AIInAALdir/libref
source $AIInAALdir/AIInAAL_env/bin/activate
aiinaalpkg="Ollama"
aiinaalpkgURL="https://ollama.com/download/ollama-linux-amd64.tgz"
aiinaaluser=$(whoami)

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
cd /tmp
echo ""
echo "Cloning official $aiinaalpkg repository to $aiinaalpkg"

#### GIT CLONE COMMAND  URL HERE ####
cd $AIInAALdir/$aiinaalpkg

echo "Changing directory ->$AIInAALdir/$aiinaalpkg"
cd $AIInAALdir/$aiinaalpkg
echo ""
echo "Installing the $aiiaalpkg binary --> $pdirectory/$aiiaalpkg/bin/ollama"
sudo curl -L $aiinaalpkgURL --create-dirs --output bin/ollama/
cd bin/ollama
sudo tar -xzf ollama-linux-amd64.tgz
sudo rm ollama-linux-amd64.tgz
cd $AIInAALdir/$aiinaalpkg
echo "The base ollama file needs to be made executable. Authorize with sudo user password below."
sudo chmod +x bin/ollama
echo ""

source $AIInAALdir/$aiinaalpkg/libref-$aiinaalpkg
echo ""
echo "Applying AIInAAL modifications to original $aiinaalpkg..."
cp -n "$AIInAALdir/$aiinaalpkg/user_customize_Ollama_example.sh" "$AIInAALdir/$aiinaalpkg/user_customize_Ollama.sh"
AIInAAL_update_$aiinaalpkg
cd $AIInAALdir/$aiinaalpkg
pip install -r requirements_$aiinaalpkg.txt

mkdir -p "$AIInAALdir/$aiinaalpkg/.ollama/models"
ln -sf "$AIInAALdir/$aiinaalpkg/.ollama" "/home/$aiinaaluser/.ollama"
echo "Initializing Ollama with IPEX for your GPU..."
#Create symlinks for ipex, ollama, and openwebui
ln -sf $AIInAALdir/AIInAAL_env/bin/ipexrun ipexrun
init-ollama
ln -sf $AIInAALdir/AIInAAL_env/bin/open-webui open-webui
echo ""

echo "Creating the launcher file ($aiinaalpkg-Start.sh)"
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
echo "ollama serve &" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "sleep 10" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "ipexrun xpu open-webui serve" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
#echo "sleep 60"
echo "Setting the new start file to be executable. (Authorization Required)"
sudo chmod +x $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "Creating executable link in /usr/bin --> AIInAAL-$aiinaalpkg"
sudo ln -sf "$AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh" "/usr/bin/AIInAAL-$aiinaalpkg"
echo "Installation complete. Start with command: AIInAAL-$aiinaalpkg with any Ollama arguments afterward"
echo "--Press any key to exit installer--"
read go
exit 0

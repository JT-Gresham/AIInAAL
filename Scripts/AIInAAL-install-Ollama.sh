#!/usr/bin/env bash

source /etc/AIInAAL/AIInAAL_path
source $AIInAALdir/libref
source $AIInAALdir/AIInAAL_env_inf/bin/activate
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
mkdir /tmp/$aiinaalpkg
cd /tmp/$aiinaalpkg
echo ""
echo "Downloading official $aiinaalpkg package to /tmp/$aiinaalpkg"
wget $aiinaalpkgURL
echo ""
echo "Decompressing Ollama package..."
tgzpkgname=$(ls | grep "tgz")
tar -xvf $tgzpkgname
echo ""
echo "Copying Ollama executable to AIInAAL environment..."
cp ./bin/ollama $AIInAALdir/AIInAAL_env_inf/bin/
echo "Copying library files to AIInAAL environment..."
cp -Rf ./lib/ollama $AIInAALdir/AIInAAL_env_inf/lib/python3.11/site-packages/
echo "Cleaning up temporary files..."
cd $AIInAALdir/$aiinaalpkg
rm -R /tmp/Ollama
echo ""

source $AIInAALdir/$aiinaalpkg/libref-$aiinaalpkg
echo ""
#echo "Applying AIInAAL modifications to original $aiinaalpkg..."
#cp -n "$AIInAALdir/$aiinaalpkg/user_customize_Ollama_example.sh" "$AIInAALdir/$aiinaalpkg/user_customize_Ollama.sh"
AIInAAL_update_$aiinaalpkg
cd $AIInAALdir/$aiinaalpkg
pip install -r requirements_$aiinaalpkg.txt

mkdir -p "$AIInAALdir/$aiinaalpkg/.ollama/models"
ln -sf "$AIInAALdir/$aiinaalpkg/" "/home/$aiinaaluser/.ollama"
echo "Initializing Ollama with IPEX for your GPU..."
#Create symlinks for ipex, ollama, and openwebui
ln -sf $AIInAALdir/AIInAAL_env_inf/bin/ipexrun ipexrun
init-ollama
ln -sf $AIInAALdir/AIInAAL_env_inf/bin/open-webui open-webui
echo ""

echo "Creating the launcher file ($aiinaalpkg-Start.sh)"
echo "#!/usr/bin/env bash" > $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "source /etc/AIInAAL/AIInAAL_path" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "source $AIInAALdir/libref" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "source $AIInAALdir/$aiinaalpkg/libref-$aiinaalpkg" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "source $AIInAALdir/AIInAAL_env_inf/bin/activate" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "AIInAAL_update" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh

#### Executable below
echo "export OLLAMA_NUM_GPU=999" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "export TORCH_DEVICE_BACKEND_AUTOLOAD=0" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "source ipex-llm-init -g --device Arc" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "AIInAAL_update_$aiinaalpkg" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "ollama serve &" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "cd $AIInAALdir/$aiinaalpkg" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "echo \"Open Web UI will start in 10 seconds. After it loads, you can open it up in your browser. (URL: localhost:8080)\"" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "sleep 10" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "open-webui serve" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "Ollama_exit" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
#echo "sleep 60"
echo "Setting the new start file to be executable. (Authorization Required)"
sudo chmod +x $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "Creating executable link in /usr/bin --> AIInAAL-$aiinaalpkg"
sudo ln -sf "$AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh" "/usr/bin/AIInAAL-$aiinaalpkg"
echo "Installation complete. Start with command: AIInAAL-$aiinaalpkg with any Ollama arguments afterward"
echo "--Press any key to exit installer--"
read go
exit 0

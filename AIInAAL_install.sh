#!/usr/bin/env bash
AIInAALuser="$(whoami)"

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
sudo pacman -S --needed intel-compute-runtime intel-graphics-compiler ocl-icd opencl-headers level-zero-loader
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
echo "Creating the AIInAAL-update command..."
echo "#!/usr/bin/env bash" > /bin/AIInAAL-update
echo "" >> /bin/AIInAAL-update
echo "source $pdirectory/AIInAAL_env/bin/activate" >> /bin/AIInAAL-update
echo "souce $pdirectory/AIInAAL/libref" >> /bin/AIInAAL-update
echo "AIInAAL_update" >> /bin/AIInAAL-update
sudo chmod +x /bin/AIInAAL-update
git clone https://github.com/JT-Gresham/AIInAAL.git
echo ""
cd $pdirectory/AIInAAL/Scripts
sudo mkdir /etc/AIInAAL
sudo touch /etc/AIInAAL/AIInAAL_path
sudo chmod 777 /etc/AIInAAL/AIInAAL_path
echo "#!/usr/bin/env bash" > /etc/AIInAAL/AIInAAL_path
echo "" > /etc/AIInAAL/AIInAAL_path
echo "pdirectory=$pdirectory" > /etc/AIInAAL/AIInAAL_path
echo "AIInAALdir=$pdirectory/AIInAAL" >> /etc/AIInAAL/AIInAAL_path
source /etc/AIInAAL/AIInAAL_path
bash $pdirectory/AIInAAL/Scripts/librefgen
echo "Changing directory ->$pdirectory/AIInAAL"
cd $pdirectory/AIInAAL
echo ""
echo "Creating python 3.11 environment (AIInAAL_env)"
/usr/bin/python3.11 -m venv $pdirectory/AIInAAL/AIInAAL_env
echo ""
echo "Activating environment -> AIInAAL_env"
source $pdirectory/AIInAAL/AIInAAL_env/bin/activate
echo ""
echo "Installing wheel package..."
pip install wheel
echo ""
echo "Installing packages from requirements_AIInAAL.txt..."
pip install -r requirements_AIInAAL.txt
#pip install ipex-llm[xpu]
ln -sf $pdirectory/AIInAAL/Scripts/ipex-llm-init $pdirectory/AIInAAL/AIInAAL_env/bin/
#Run after git pull

#!/usr/bin/env bash

source /etc/AIInAAL/AIInAAL_path
source $AIInAALdir/libref
source $AIInAALdir/AIInAAL_env/bin/activate
aiinaalpkg="CrewAI"
aiinaalpkgURL="https://github.com/crewAIInc/crewAI.git"

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
#wget -O - https://github.com/crewAIInc/crewAI/archive/master.tar.gz | tar -xz --strip=2 "crewAI-main/src/crewai"
git clone "https://github.com/strnad/CrewAI-Studio.git"
cp -R /tmp/CrewAI-Studio/* $AIInAALdir/$aiinaalpkg/
cp $AIInAALdir/Scripts/crewai $AIInAALdir/AIInAAL_env/bin/
sed -i "s|10062024|#!$AIInAALdir/$aiinaalpkg|g" $AIInAALdir/AIInAAL_env/bin/crewai
rmdir -R /tmp/crewai
cd $AIInAALdir/$aiinaalpkg
source $AIInAALdir/$aiinaalpkg/libref-$aiinaalpkg
echo ""
echo "Applying AIInAAL modifications to original $aiinaalpkg..."
cp -n "$AIInAALdir/"$aiinaalpkg"/user_customize_CrewAI_example.sh" "$AIInAALdir/"$aiinaalpkg"/user_customize_CrewAI.sh"
AIInAAL_update_$aiinaalpkg
#echo ""
#echo "Installing packages from requirements.txt..."
cd $AIInAALdir/$aiinaalpkg
#sleep 1
pip install -r requirements.txt
#pip install -r requirements_$aiinaalpkg.txt
#echo ""
#echo "Creating the launcher file ($aiinaalpkg-Start.sh)"
#touch $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
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
echo "cd $AIInAALdir/$aiinaalpkg" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
#echo "cd $AIInAALdir/$aiinaalpkg/MyCrewAIProjects" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "streamlit run app/app.py --server.headless True \"\$@\"" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
#echo "python3 $AIInAALdir/AIInAAL_env/bin/crewai \"\$@\"" >> $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
#echo "sleep 60"
echo "Setting the new start file to be executable. (Authorization Required)"
sudo chmod +x $AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh
echo "Creating executable link in /usr/bin --> AIInAAL-$aiinaalpkg"
sudo ln -sf "$AIInAALdir/$aiinaalpkg/$aiinaalpkg-Start.sh" "/usr/bin/AIInAAL-$aiinaalpkg"
echo "Installation complete. Start with command: AIInAAL-$aiinaalpkg with any CrewAI arguments afterward"
echo "--Press any key to exit installer--"
read go
exit 0

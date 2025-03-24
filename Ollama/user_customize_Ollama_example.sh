#!/usr/bin/env bash
source AIInAAL/libref
export OLLAMA_NUM_GPU=999
####  This file is for you to add any code you want to execute just before CrewAI launches.  This will not be updated when AIInAAL or CrewAI updates.
####  This is useful if you want to create custom presets and make sure your code, links, etc gets put back after an official update from the CrewAI team.
####  I'll include the code I wrote to load my own custom preset as an example.  I didn't wnat to do this every time the CrewAI team updated...

####  THIS CODE STARTS IN YOUR PARENT DIRECTORY
####    eg: where the AIInAAL directory is located

#### EXAMPLE CODE ####

#  Change directory to make things easier
#cd $pdirectory/AIInAAL

##############################################
# AUTOSTART Open WebUI in browser and DAEMON #

browserchoice="firefox"

while [ 1 ]
do
ollamabinpid=$(pgrep -f "ollama-bin serve")
ollamabinmem=$(RSSfull=$(cat /proc/$ollamabinpid/status | grep RSS); echo $RSSfull | cut -d\  -f2)
if [[ $ollamabinmem -ge "1" ]]
	then
		echo "Ollama-bin Activated!"
		sleep 3
		open-webui serve &
		break
	else
		echo "Ollama-bin activation check: Waiting..."
		sleep 3
fi
done

while [ 1 ]
do
openwebuipid=$(pgrep -f "open-webui serve")
openwebuimem=$(RSSfull=$(cat /proc/$openwebuipid/status | grep RSS); echo $RSSfull | cut -d\  -f2)
if [[ $openwebuimem -ge "1751916" ]]
	then
		echo "OpenWebUI Activated!"
		sleep 3
		firefox "http://0.0.0.0:8080/auth/"
		break
	else
		echo "OpenWebUI activation: Waiting..."
		sleep 3
fi
done

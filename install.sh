#!/bin/bash



os_detect(){
        
        if [[ $(which pacman) != '' ]]; then
                OS="Arch"
        elif [[ $(which apt) != '' ]]; then
                OS="Debian"
        elif [[ $(which dnf) != '' ]]; then
                OS="Redhat"
        fi
}


arch_installation(){
        echo "installing mpd, qs, ffmpeg, please enter your password:"
        sleep 1
        sudo pacman -S mpd quickshell ffmpeg
        echo ""
        echo ""
        echo "Dependencies properly installed"
}

redhat_installation(){
        echo "installing yt-dlp and ffmpeg with dnf, please enter your password:"
        sleep 1
        sudo dnf install ffmpeg mpd quickshell
        echo ""
        echo ""
        echo "Dependencies properly installed"
        sleep 1

}

debian_installation(){
        echo "installing yt-dlp and ffmpeg with apt, please enter your password:"
        sleep 1
        sudo apt install ffmpeg quickshell mpd
        echo ""
        echo ""
        echo "Dependencies properly installed"
        sleep 1
}


distro_installation (){
       if [[ $OS == "Arch" ]];then
             arch_installation
        elif [[ $OS == "Redhat" ]]; then
                redhat_installation
        elif [[ $OS == "Debian" ]]; then
                debian_installation

	fi
 
}


fill_config (){

	echo "Making the config files..."
	echo "Step 1: MPD music directory"
	echo "Where is your music stored?"
	echo ""
	printf "Enter the path: "
	read music_dir
	echo
	echo "MUSIC_DIR=\"$music_dir\"" >> ~/.config/mpd_quickshell_widget/config
	echo ""
	echo "Step 2: MPD host"
	echo "where is your MPD instance running ? (don't add the \"~\", the installer expects you to start with your home dir, or you can just start with \"\/\""
	echo " [ I ] I know the IP "
	echo " [ D ] I have a domain name "
	read -sn 1 host_type
	if [[ $host_type == 'i' ]] || [[ $host_type == 'I' ]] then
		printf "So you know your instance's IP adress, type it here: "
		read ip
		echo "writing IP to config file"
		echo "MPD_HOST=\"$ip\"" >> ~/.config/mpd_quickshell_widget/config

	elif [[ $host_type == 'd' ]] || [[ $host_type == 'D' ]] then

		printf "So you have a domain name, type it here: "
		read domain_name
		echo "writing domain name to config file"
		echo "MPD_HOST=\"\$(dig +short $domain_name)\"" >> ~/.config/mpd_quickshell_widget/config

	fi
	echo "config completed, finalizing installation..."
	sleep 2
}

installation(){

        echo ""
        echo ""
        echo "getting the last version of the widget from github..."
        sleep 1
        git clone https://github.com/AR4eL974/mpd_quickshell_widget.git ~/.config/mpd_quickshell_widget
        echo ""
        echo "repo successfully cloned"
        sleep 1
        echo ""
        echo "deleting installation files..."
        cd ~/.config/mpd_quickshell_widget
        rm example.png
        rm LICENSE
        rm -rf .git/
	fill_config
        sleep 1
        echo ""
        echo ""
        echo "giving execution permissions to the executable"
        chmod +x main.sh 
        chmod +x launch_qs
        sleep 1
        echo ""
        echo "installation complete, the installer will now remove itself"
        sleep 1
        rm install.sh
        cd 
}

language_choice
os_detect
echo ""
echo "OS Detected: $OS based Linux, proceeding to installation for this OS"
sleep 1
distro_installation
installation







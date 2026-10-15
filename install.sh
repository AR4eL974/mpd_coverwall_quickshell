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

installation(){

        fichier="soundcloud.sh"
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







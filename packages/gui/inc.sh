#!/bin/bash


function install_chrome {
    if ! command -v google-chrome-stable &> /dev/null
    then
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo dpkg -i google-chrome-stable_current_amd64.deb
        sudo apt --fix-broken install
        rm google-chrome-stable_current_amd64.deb
    fi
}

function test_chrome {
    echo "no tests for chrome"
}

function install_editors {
    sudo snap install code --classic
    sudo snap install atom --classic
}

function test_editors {
    echo "no tests for editors"
}

function install_gns3 {
    if ! [ -x "$(command -v gns3)" ]; then
        sudo add-apt-repository ppa:gns3/ppa -y && \
            sudo apt update -y && \
            sudo apt install gns3-gui gns3-server -y
    fi
}

function test_gns3 {
    echo "no tests for gns3"
}

function install_security {
    sudo snap install 1password
    sudo apt-get install gnupg kgpg -y
}

function test_security {
    echo "no tests for security"
}

function install_video {
    sudo apt install ffmpeg vlc -y
}

function test_video {
    echo "no tests for video"
}

function install_edge {
    if ! [ -x "$(command -v microsoft-edge-stable)" ]; then
        curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
        sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
        sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
        sudo rm microsoft.gpg
        sudo apt update

        sudo apt install microsoft-edge-stable -y
    fi
}

function test_edge {
    echo "no tests for edge"
}

function install_vivaldi {
    if ! [ -x "$(command -v vivaldi-stable)" ]; then
        curl -fSsL https://repo.vivaldi.com/archive/linux_signing_key.pub \
            | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vivaldi.gpg > /dev/null
        echo deb [arch=amd64 signed-by=/usr/share/keyrings/vivaldi.gpg] \
            https://repo.vivaldi.com/archive/deb/ stable main \
            | sudo tee /etc/apt/sources.list.d/vivaldi.list
        sudo apt update
    fi

    sudo apt install vivaldi-stable -y
}

function test_vivaldi {
    echo "no tests for vivaldi"
}

function install_browsers() {
    sudo snap install thunderbird
    sudo snap install chromium
    sudo snap install chromium-ffmpeg
    sudo snap install opera
    sudo snap install brave
}

function test_browsers {
    echo "no tests for browsers"
}

function install_creativity {
    sudo apt install gimp -y

    if ! [ -x "$(command -v inkscape)" ]; then
        sudo add-apt-repository ppa:inkscape.dev/stable -y
        sudo apt update
        sudo apt install inkscape -y
    fi

    snap install blender --classic

    if ! [ -x "$(command -v obs)" ]; then
        sudo add-apt-repository ppa:obsproject/obs-studio -y
        sudo apt install obs-studio -y
    fi
    sudo apt install audacity -y
    sudo snap install lunacy
}

function test_creativity {
    echo "no tests for creativity"
}

function install_jetbrain_pro {
    sudo snap install intellij-idea-ultimate --classic
    sudo snap install rider --classic
    sudo snap install goland --classic
    sudo snap install pycharm-professional --classic
    sudo snap install webstorm --classic
    sudo snap install datagrip --classic
    sudo snap install clion --classic
    sudo snap install rubymine --classic
}

function test_jetbrain_pro {
    echo "no tests for jetbrain_pro"
}
#!/bin/bash

greeting() {
    echo ""
    echo "Installing code-launcher..."
    echo ""
    echo "Make sure the following dependencies are installed:"
    echo "    - git-cli"
    echo "    - wget"
    echo ""
    echo "Installing dependencies: "
    echo "    - fzf"
    echo "    - code-launcher"
    echo ""
    echo "Continue?"
    read -p "[Y/n] " opt

    if [[ $opt = "n" || $opt = "N" || opt = "no" || opt = "No" || opt = "nO" || opt = "NO" ]]; then 
        echo "Ending installation..."
        exit 0
    fi
}

check_installed() {
    local program_name="$1"
    if command -v "$program_name" &> /dev/null; then
        return 1
    else
        return 0
    fi
}

export_to_path() {
    if ! grep -qxF 'export PATH="$PATH:$HOME/.local/share"' ~/.bashrc; then
        echo 'export PATH="$PATH:$HOME/.local/share"' >> ~/.bashrc
        source ~/.bashrc
        echo "codl added to path..."
    else
        echo "codl already in path..."
    fi
}

install_fzf() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

install_codl() {
    echo "Gettting latest version of code-launcher..."
    echo ""
    echo ""
    mkdir ~/.local/share/ 
    rm ~/.local/share/codl
    wget https://github.com/jtomaspm/code-launcher/raw/main/src/codl &&
    mv codl ~/.local/share/codl
    chmod +x ~/.local/share/codl
    export_to_path    
} 

install_deps() {
    check_installed "fzf"
    if [[ $? -eq 0 ]]; then
        install_fzf
    else
        echo "fzf already installed, skipping..."
    fi
    install_codl

    if stat "${HOME}/.config/code-launcher/config.yaml" &> /dev/null; then
        echo "Config found, skipping add default config..."
    else
        add_default_config
    fi
}

add_default_config() {
    echo "Adding default config..."
    mkdir ~/.config/code-launcher/
    touch ~/.config/code-launcher/config.yaml
    echo 'paths:' >> ~/.config/code-launcher/config.yaml
    echo '- ~/Documents/code/' >> ~/.config/code-launcher/config.yaml
    echo 'launchers:' >> ~/.config/code-launcher/config.yaml
    echo '- code .' >> ~/.config/code-launcher/config.yaml
    echo '- nvim .' >> ~/.config/code-launcher/config.yaml
}

main() {
    greeting
    install_deps
} 

main
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
        return 0
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

install_fzf() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

install_codl() {
    echo "Gettting latest version on code-launcher..."
    echo ""
    echo ""
    rm ~/.local/share/codl
    wget https://github.com/jtomaspm/code-launcher/raw/main/src/codl
    mv codl ~/.local/share/codl
    chmod +x ~/.local/share/codl
    export PATH="$PATH:$HOME/.local/share/codl"
} 

install_deps() {
    check_installed "fzf"
    if [[ $? -eq 0 ]]; then
        install_fzf
    else
        echo "fzf already installed, skipping..."
    fi
    install_codl
}

main() {
    greeting
    install_deps
} 

main
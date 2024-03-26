#!/bin/bash

greeting() {
    echo ""
    echo "Installing code launcher..."
    echo "Make sure the following dependencies are installed:"
    echo "    - Git CLI"
    echo ""
    echo "Continue?"
    read -p "[Y/n] " opt

    if [[ $opt = "n" || $opt = "N" || opt = "no" || opt = "No" || opt = "nO" || opt = "NO" ]]; then 
        echo "Ending installation..."
        return 0
    fi
}

install_fzf() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

main() {
    greeting
    install_fzf
} 

main
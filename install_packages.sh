#!/bin/bash
set -ex
# Run only on osx
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Running package install on OSX"
    # brew is not installed install it
    if [[ ! -f /usr/local/bin/brew ]]; then
        echo "Installing brew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew install nvim fzf gh
        # Enhance our toolset.
        # btop -> htop but better
        # bat -> cat but better
        # ncdu -> du but better
        # the_silver_searcher -> grep but MUCH better
        # duf -> df but better
        brew btop bat ncdu the_silver_searcher duf go
        # Alacritty is a terminal emulator that is GPU accelerated.
        # No features == Super fast
        brew install --cask alacrity
        # Uncomment the following lines to install yabai and skhd
        # brew install koekeishiya/formulae/yabai
        # brew install koekeishiya/formulae/skhd
        # Yabai needs some special permissions to run so must be enabled here.
        # https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)
    fi
else if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    is_ubuntu=$(cat /etc/os-release | grep -i ubuntu)
    if [[ -z $is_ubuntu ]]; then
        echo "Running package install on Ubuntu"
        sudo apt update
        sudo apt install -y neovim fzf gh
        sudo apt install -y btop bat ncdu the_silver_searcher duf go
        # sudo apt install -y alacritty
    else
        echo "Linux not supported yet"
        exit 1
    fi
fi
# Fonts installation is also important.
# TODO: Add a README and the details there?
# Fonts: install powerline nerdfont (note this needs to be in your local system not on the remote system)
# https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
# https://www.nerdfonts.com/font-downloads

#!/bin/zsh

echo "Installing Oh My Zash"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Oh my zash ready"

echo "Installing brew"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Brew ready"

echo "Cloning dotfiles"

git clone https://github.com/mmazurowski/.dotfiles ~/.dotfiles

echo "Dotfiles ready"

cd ~/.dotfiles

brew install stow

stow zsh -v
stow tmux -v
stow nvim -v
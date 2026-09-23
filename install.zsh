#!/bin/zsh
set -e

echo "Installing Oh My Zsh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Oh My Zsh ready"

echo "Installing brew"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Brew ready"

# Oh My Zsh drops its own ~/.zshrc, and `stow zsh` needs that path free. Move it
# aside rather than deleting it — on a machine that already had a zshrc, an
# unconditional `rm` here is silent data loss.
if [[ -e ~/.zshrc && ! -L ~/.zshrc ]]; then
  backup=~/.zshrc.pre-dotfiles.$(date +%Y%m%d%H%M%S)
  mv ~/.zshrc "$backup"
  echo "Existing ~/.zshrc moved to $backup"
fi

echo "Cloning dotfiles"

if [[ ! -d ~/.dotfiles ]]; then
  git clone https://github.com/mmazurowski/.dotfiles ~/.dotfiles
fi

echo "Dotfiles ready"

cd ~/.dotfiles

brew install stow

stow zsh -v
stow tmux -v
stow nvim -v
stow starship -v
stow ghostty -v
stow lazygit -v
stow git -v
stow kitty -v
stow aerospace -v

echo "Installing brew dependencies"

brew install nvm yq jq tmux terraform tfsec awscli glow neovim gh tig fzf starship fd ripgrep lazygit mise
brew install --cask ghostty font-jetbrains-mono-nerd-font

# tmux plugin manager — plugins are installed from inside tmux with `prefix + I`
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "Installing neovim plugins"

nvim --headless "+Lazy! sync" +qa

echo "Done. Open a new shell, then run 'prefix + I' inside tmux to fetch its plugins."

# Dotfiles for managing configs

## Requirements

Files are managed by symlinks using GNU stow

```shell
brew install stow
```

# Philosophy

Each directory in a repository is being symlinked by `stow`.

**ZSH**
Configuration is being divided into directories, each must contain main.zsh that is being sourced in a `.zshrc` confguration.

# Setup

Clone this repository to your home directory. Then run following commands to symlink configs

```shell
stow zsh -v
stow tmux -v
```

Ref 1. https://www.jakewiesler.com/blog/managing-dotfiles

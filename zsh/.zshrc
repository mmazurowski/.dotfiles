# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Define theme
ZSH_THEME="robbyrussell"

# Define zsh plugins
plugins=(git gh nvm terraform dotenv)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Includes partials
source <(cat ~/.zsh/aliases/*)
source <(cat ~/.zsh/completions/*)

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

source "$HOME/.cargo/env"

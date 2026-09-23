# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Prompt is handled by Starship (see `eval` below) — leave the OMZ theme empty.
ZSH_THEME=""

# Define zsh plugins
plugins=(git gh nvm terraform dotenv)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Starship prompt — replaces the OMZ theme. The Azure profile indicator
# (keyed on AZURE_CONFIG_DIR) now lives natively in ~/.config/starship.toml.
eval "$(starship init zsh)"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Includes partials
source <(cat ~/.zsh/aliases/*)
source <(cat ~/.zsh/completions/*)
source <(cat ~/.zsh/configs/*)

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

source "$HOME/.cargo/env"
export PATH="/opt/homebrew/opt/pnpm@9/bin:$PATH"
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# pnpm
export PNPM_HOME="/Users/mmazurowski/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#
eval "$(mise activate zsh)"

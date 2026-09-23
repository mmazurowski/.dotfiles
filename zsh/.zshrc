# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Prompt is handled by Starship (see `eval` below) — leave the OMZ theme empty.
ZSH_THEME=""

# Define zsh plugins
plugins=(git gh nvm terraform dotenv)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Homebrew lives in /opt/homebrew on Apple Silicon and /usr/local on Intel.
# Everything below (and the partials in ~/.zsh) uses $HOMEBREW_PREFIX rather
# than hardcoding one of them.
if [[ -z "$HOMEBREW_PREFIX" ]]; then
  for _brew_dir in /opt/homebrew /usr/local; do
    if [[ -x "$_brew_dir/bin/brew" ]]; then
      export HOMEBREW_PREFIX="$_brew_dir"
      break
    fi
  done
  unset _brew_dir
fi
: "${HOMEBREW_PREFIX:=/opt/homebrew}"

# Starship prompt — replaces the OMZ theme. The Azure profile indicator
# (keyed on AZURE_CONFIG_DIR) now lives natively in ~/.config/starship.toml.
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

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

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

[[ -d "$HOMEBREW_PREFIX/opt/pnpm@9/bin" ]] && export PATH="$HOMEBREW_PREFIX/opt/pnpm@9/bin:$PATH"

# 1Password SSH agent (used for git commit signing)
[[ -S "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" ]] \
  && export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"

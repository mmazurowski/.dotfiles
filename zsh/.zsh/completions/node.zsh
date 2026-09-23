export NVM_DIR="$HOME/.nvm"
[[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ]] && source "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
[[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ]] \
  && source "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"

command -v npm >/dev/null 2>&1 && source <(npm completion)

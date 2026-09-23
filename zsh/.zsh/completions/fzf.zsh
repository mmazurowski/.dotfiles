# Setup fzf
if [[ -d "$HOMEBREW_PREFIX/opt/fzf/bin" && ! "$PATH" == *"$HOMEBREW_PREFIX/opt/fzf/bin"* ]]; then
  PATH="${PATH:+${PATH}:}$HOMEBREW_PREFIX/opt/fzf/bin"
fi

# Auto-completion and key bindings — only if fzf is actually installed.
[[ -f "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" ]] \
  && source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"
[[ -f "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]] \
  && source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"

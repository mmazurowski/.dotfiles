# Configure AWS CLI autocompletion.
# NOTE: aws_completer is a binary, not a directory — it belongs in `complete`,
# never on $PATH.
if [[ -x "$HOMEBREW_PREFIX/bin/aws_completer" ]]; then
  complete -C "$HOMEBREW_PREFIX/bin/aws_completer" aws
fi

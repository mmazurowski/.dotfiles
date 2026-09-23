# `y` opens yazi and leaves the shell in whatever directory you quit from
# (plain `yazi` can't change the parent shell's cwd). Quit with `q`; use `Q` to
# quit without changing directory.
y() {
  local tmp cwd
  tmp="$(mktemp -t yazi-cwd.XXXXXX)" || return
  yazi "$@" --cwd-file="$tmp"
  if IFS= read -r -d '' cwd < "$tmp" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    builtin cd -- "$cwd" || return
  fi
  rm -f -- "$tmp"
}

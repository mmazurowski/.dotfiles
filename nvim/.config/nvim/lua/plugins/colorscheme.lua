-- Matches the Ghostty / tmux / lazygit / fzf palette: base16 black-metal.
-- Swapping themes means changing this file AND the corresponding theme lines in
-- ghostty/.config/ghostty/config and tmux/.config/tmux/tmux.conf.
return {
  { "RRethy/base16-nvim", lazy = false, priority = 1000 },
  { "LazyVim/LazyVim", opts = { colorscheme = "base16-black-metal" } },
}

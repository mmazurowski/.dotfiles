# Dotfiles for managing configs

## Requirements

Files are managed by symlinks using GNU stow

```shell
brew install stow
```

# Philosophy

Each directory in a repository is being symlinked by `stow`.

**ZSH**
Configuration is being divided into directories. Each directory content is automatically sourced so just add new `*.zsh` file and have fun!

# Setup

Clone this repository to your home directory. Then run following commands to symlink configs

```shell
stow zsh -v
stow tmux -v
stow nvim -v
stow starship -v
stow ghostty -v
stow lazygit -v
stow git -v
```

## Install script

Install script was hand written and is subject of (many) issues. To be verified in the future.

Ref 1. https://www.jakewiesler.com/blog/managing-dotfiles

# Fresh machine

```shell
# 1. tools
brew install stow tmux neovim git ripgrep fd fzf lazygit starship
brew install --cask ghostty font-jetbrains-mono-nerd-font

# 2. configs
git clone git@github.com:mmazurowski/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles && stow zsh tmux nvim starship ghostty lazygit git -v

# 3. tmux plugins — prefix is C-a, so: C-a I
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# 4. neovim plugins install themselves on first launch
nvim --headless "+Lazy! sync" +qa
```

Neovim needs **0.11.2+**. Flutter work additionally needs the Flutter SDK on
`PATH` (`brew install --cask flutter`); `flutter-tools.nvim` is inert without it.

# Theme

Everything shares one palette: **base16 black-metal**, sourced from
[`RRethy/base16-nvim`](https://github.com/RRethy/base16-nvim)
(`lua/colors/black-metal.lua`). Neovim uses the plugin directly; the other tools
use theme files **vendored into this repo** so a fresh clone is themed before
any plugin has been downloaded.

| Tool    | File                                            |
| ------- | ----------------------------------------------- |
| Ghostty | `ghostty/.config/ghostty/themes/black_metal`    |
| tmux    | `tmux/.config/tmux/themes/black_metal.tmux`     |
| lazygit | `lazygit/.config/lazygit/config.yml`            |
| fzf     | `zsh/.zsh/configs/fzf-theme.zsh`                |
| Neovim  | `nvim/.config/nvim/lua/plugins/colorscheme.lua` |

`tokyonight_moon` is vendored alongside it for Ghostty and tmux. Switching is a
comment swap in `ghostty/.config/ghostty/config` and
`tmux/.config/tmux/tmux.conf`, plus the colorscheme name in `colorscheme.lua`.

lazygit does not read `~/.config/lazygit` on macOS by default, so
`zsh/.zsh/configs/lazygit.zsh` exports `LG_CONFIG_FILE` to point at the stowed
file.

## Updating a vendored theme

Vendored files carry a header naming their upstream path and commit. Never
symlink into `~/.local/share/nvim/lazy/...` — that path does not exist on a
fresh machine. Re-vendor by hand:

```shell
git clone --depth 1 https://github.com/RRethy/base16-nvim /tmp/base16
# re-derive the palette, keep the header comment up to date with the new commit
git -C /tmp/base16 log -1 --format=%H
```

For tokyonight the upstream files live under `extras/` in
[`folke/tokyonight.nvim`](https://github.com/folke/tokyonight.nvim)
(`extras/ghostty/tokyonight_moon`, `extras/tmux/tokyonight_moon.tmux`).

# Neovim

LazyVim. Extras are declared in `nvim/.config/nvim/lazyvim.json`; local
overrides live in `lua/plugins/`.

- TypeScript is served by **vtsls**. `ts_ls`/`tsserver` are explicitly disabled —
  do not enable them alongside it.
- Dart/Flutter is served by **flutter-tools.nvim**, which owns `dartls`. Do not
  enable the `lang.dart` extra or configure `dartls` via `nvim-lspconfig`; both
  would start competing servers.
- Formatting goes through `conform.nvim` (prettier for JS/TS, `dart_format` for
  Dart).

## Agent keymaps

`claudecode.nvim` is the primary Claude Code integration; `sidekick.nvim`
provides a terminal for any agent CLI. Both default to `<leader>a*`, so the
overlapping maps are de-conflicted in `lua/plugins/ai.lua`.

| Key          | Action                                          |
| ------------ | ----------------------------------------------- |
| `<leader>ac` | Toggle Claude Code                              |
| `<leader>af` | Focus Claude Code                               |
| `<leader>ab` | Add current buffer to Claude context            |
| `<leader>as` | Send selection (visual) / add file (explorer)   |
| `<leader>ar` | Resume Claude · `<leader>aC` continue           |
| `<leader>ay` | Accept Claude diff                              |
| `<leader>an` | Deny Claude diff                                |
| `<leader>aa` | Sidekick: toggle CLI picker                     |
| `<leader>aS` | Sidekick: select CLI · `<leader>aF` send file   |
| `<leader>gv` | Diffview open · `<leader>gV` close              |
| `<leader>qs` | Restore session · `<leader>fp` projects picker  |

Copilot Next Edit Suggestions are **off** (`nes.enabled = false`), so sidekick
registers no `copilot` LSP server and `<tab>` keeps its normal behaviour. Turn
them back on in `lua/plugins/ai.lua` if a subscription appears.

Saving a claudecode `(proposed)` buffer is what **accepts** a diff, so those
buffers are opted out of format-on-save in `lua/plugins/ai.lua`. Don't add an
autosave plugin without extending that guard.

## Parallel agents

`claude --worktree <name>` puts each task in its own git worktree, so several
agents can work without fighting over the index. Pair one tmux session with one
worktree:

```shell
claude --worktree refactor-auth          # creates .claude/worktrees/refactor-auth
tmux new -s refactor-auth -c .claude/worktrees/refactor-auth
```

`.claude/worktrees/` is ignored globally via `git/.config/git/ignore`. Review a
worktree's changes with `<leader>gv` (diffview); it refreshes automatically when
an agent edits files on disk.

#!/usr/bin/env bash
# Derived from base16 black-metal — RRethy/base16-nvim: lua/colors/black-metal.lua @ 44fc7a0
# base00 #000000  base01 #121212  base02 #222222  base03 #333333
# base04 #999999  base05 #c1c1c1  base08 #5f8787  base0A #a06666
# base0B #dd9999  base0D #888888

set -g mode-style "fg=#dd9999,bg=#222222"

set -g message-style "fg=#dd9999,bg=#222222"
set -g message-command-style "fg=#dd9999,bg=#222222"

set -g pane-border-style "fg=#333333"
set -g pane-active-border-style "fg=#dd9999"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=#c1c1c1,bg=#121212"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#000000,bg=#dd9999,bold] #S #[fg=#dd9999,bg=#121212,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#121212,bg=#121212,nobold,nounderscore,noitalics]#[fg=#dd9999,bg=#121212] #{prefix_highlight} #[fg=#222222,bg=#121212,nobold,nounderscore,noitalics]#[fg=#c1c1c1,bg=#222222] %Y-%m-%d  %H:%M #[fg=#dd9999,bg=#222222,nobold,nounderscore,noitalics]#[fg=#000000,bg=#dd9999,bold] #h "

setw -g window-status-activity-style "underscore,fg=#999999,bg=#121212"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#999999,bg=#121212"
setw -g window-status-format "#[fg=#121212,bg=#121212,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#121212,bg=#121212,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#121212,bg=#222222,nobold,nounderscore,noitalics]#[fg=#dd9999,bg=#222222,bold] #I  #W #F #[fg=#222222,bg=#121212,nobold,nounderscore,noitalics]"

# tmux-plugins/tmux-prefix-highlight support
set -g @prefix_highlight_output_prefix "#[fg=#a06666]#[bg=#121212]#[fg=#121212]#[bg=#a06666]"
set -g @prefix_highlight_output_suffix ""

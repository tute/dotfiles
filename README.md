My customizations on top of https://github.com/thoughtbot/dotfiles.

Using [RCM](http://thoughtbot.github.io/rcm/rcm.7.html).

## New computer setup instructions

- `ssh-keygen -t ed25519` and allow in GitHub
- Clone dotfiles repos down to `~/Code/opensource`
- Run `rcup`
- In `~/.config/nvim/init.vim`:
```
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
```
- Firefox Preferences: Vertical tabs to the left
- Link config rules
  - omarchy: `ln -s ~/Code/opensource/dotfiles/arch/hypr ~/.config/hypr`
  - apps: `ln -s ~/Code/opensource/dotfiles/cursor/.cursor .cursor`

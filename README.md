My customizations on top of https://github.com/thoughtbot/dotfiles.

Using [RCM](http://thoughtbot.github.io/rcm/rcm.7.html).

## New computer setup instructions

- `ssh-keygen -t ed25519` and allow in GitHub
- Clone dotfiles repos down to `~/Code/opensource`
- Run `rcup`
- Run `./macos-defaults.sh` (macOS system preferences & animations)
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
  - Obsidian (quit Obsidian first): `ln -s ~/Code/opensource/dotfiles/obsidian ~/Code/Notes/.obsidian`
    - Install plugin binaries (not tracked in git): `bash ~/Code/opensource/dotfiles/obsidian/install-plugins.sh`
    - After first launch, re-enter Remotely Save credentials (`plugins/remotely-save/data.json` is gitignored).
- omarchy-theme-install https://github.com/Nirmal314/omarchy-van-gogh-theme

My customizations on top of https://github.com/thoughtbot/dotfiles.

Using [RCM](http://thoughtbot.github.io/rcm/rcm.7.html).

## New computer setup instructions

- Clone repos down to `~/Code/opensource`
- Run `rcup`
- Installed cursor with https://www.gitrollup.com/r/install-cursor.sh, taken
  from the comments in  https://gist.github.com/evgenyneu/5c5c37ca68886bf1bea38026f60603b6
  (and switched apt-get by yay)
- Link config rules
  - `ln -s ~/Code/opensource/dotfiles/arch/hypr ~/.config/hypr` in omarchy
  - `ln -s ~/Code/opensource/dotfiles/cursor/.cursor .cursor` in relevant projects
- `ssh-keygen -t ed25519`

# CLI utilities
sudo apt update
sudo apt install git gitk silversearcher-ag vim ctags tmux tmate curl \
  net-tools openssh-server rcm zsh gnome-tweak-tool
# Map: caps to ctrl, Compose Key: Right Alt for Spanish accents
# Go to Firefox Menu, Customize, uncheck "Title Bar" to hide it for more vertical space

# zsh, dotfiles
chsh -s $(which zsh)
git clone git@github.com:thoughtbot/dotfiles.git ~/Code/opensource/tb-dotfiles
git clone git@github.com:tute/dotfiles.git ~/Code/opensource/dotfiles
env RCRC=$HOME/Code/opensource/dotfiles/rcrc rcup
# Log out and log back in for some changes to take effect

# mise manage languages versions
# mise install in projects

# PostgreSQL, redis
sudo apt install redis-server postgresql postgresql-contrib libpq-dev
sudo -u postgres -i
CREATE ROLE tute superuser;
CREATE USER tute;
ALTER ROLE tute WITH LOGIN;

# Apps to install manually: Slack, VS Code, 1Password X
# Set Slack to open links in normal browser (about:profiles)
# Facetime camera doesn't work; https://github.com/patjak/bcwc_pcie isn't stable

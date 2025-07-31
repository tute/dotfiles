# CLI utilities
yay -S install git silversearcher-ag vim ctags tmux curl rcm zsh
# Go to Firefox Preferences: warn on closing multiple tab / vertical tabs to the left

# zsh, dotfiles
chsh -s $(which zsh)
git clone git@github.com:thoughtbot/dotfiles.git ~/Code/opensource/tb-dotfiles
git clone git@github.com:tute/dotfiles.git ~/Code/opensource/dotfiles
env RCRC=$HOME/Code/opensource/dotfiles/rcrc rcup
# Log out and log back in for changes to take effect

# PostgreSQL, redis
sudo apt install redis-server postgresql postgresql-contrib
sudo -u postgres -i
CREATE ROLE tute superuser;
CREATE USER tute;
ALTER ROLE tute WITH LOGIN;

# Apps to install manually: Slack, Cursor
# Set Slack to open links in normal browser (about:profiles)

# Setup ethernet 1000mbps:
# sudo ip link set eno1 down
# sudo ethtool -s eno1 speed 1000 duplex full autoneg on advertise 0x020
# sudo ip link set eno1 up

# CLI utilities
yay -S install git the_silver_searcher vim ctags tmux curl rcm zsh \
  gnome-keyring seahorse

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

# Installed cursor with https://www.gitrollup.com/r/install-cursor.sh, taken
# from the comments in https://gist.github.com/evgenyneu/5c5c37ca68886bf1bea38026f60603b6
# (switched apt-get by yay)

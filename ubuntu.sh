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

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.0
echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
# echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc

# Ruby
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
sudo apt install automake autoconf libreadline-dev libncurses-dev libssl-dev \
  libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev zlib1g-dev
asdf install ruby 2.6.6
asdf global ruby 2.6.6

# PostgreSQL, redis
sudo apt install redis-server postgresql postgresql-contrib libpq-dev
sudo -u postgres -i
CREATE ROLE tute superuser;
CREATE USER tute;
ALTER ROLE tute WITH LOGIN;

# Node, Yarn
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install nodejs 12.16.2
asdf global nodejs 12.16.2
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn

# Apps to install manually: Slack, VS Code, 1Password X
# Set Slack to open links in normal browser (about:profiles)
# Facetime camera doesn't work; https://github.com/patjak/bcwc_pcie isn't stable

# CLI utilities
sudo apt update
sudo apt install git gitk silversearcher-ag vim ctags tmux tmate curl net-tools openssh-server
sudo apt install gnome-tweak-tool # Map: caps to ctrl, Compose Key: Right Alt

# zsh, dotfiles
sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
sudo apt install rcm zsh
chsh -s $(which zsh)
git clone git@github.com:thoughtbot/dotfiles.git ~/Sites/tb-dotfiles
git clone git@github.com:tute/dotfiles.git ~/Sites/dotfiles
env RCRC=$HOME/Sites/dotfiles/rcrc rcup
# logout and log back in

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.0
echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc

# Ruby
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
sudo apt install automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev
asdf install ruby 2.5.5
asdf global ruby 2.5.5

# PostgreSQL, redis
sudo apt install redis-server postgresql postgresql-contrib libpq-dev

# Qt5.5
sudo apt install qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x

# Node, Yarn
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install nodejs 10.1.0
asdf global nodejs 10.1.0
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn

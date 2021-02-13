#!/bin/bash

cd
wget -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
install apt-cyg /bin
apt-cyg install \
    lynx \
    vim \
    bash-completion \
    curl \
    git \
    rsync \
    cron \
    procps-ng \
    xlaunch \
    cygutils-extra \
    python \
    p7zip \
    zip \
    unzip \
    xinit \
    git-completion \
    cron \
    git-gui \
    gitk \
    dos2unix \
    ctags \
    cscope \
    chere \
    gnupg \
    make \
    tmux \
    python2-pip \
    pygments \
    python2-pygments \
    python-pygments \
    cloc \
    fzf \
    fzf-bash \
    fzf-bash-completion \
    jq \
    moreutils \
    most \
    the_silver_searcher \
    tig

git clone http://github.com/johatfie/dotfiles .dotfiles
mkdir .dotfiles_orig
mv .bash_profile .dotfiles_orig/
mv .bashrc .dotfiles_orig/
mv .inputrc .dotfiles_orig/
mv .profile .dotfiles_orig/
cd .dotfiles
# cat mk_links

ln -s ~/.dotfiles/bash_aliases   ~/.bash_aliases
ln -s ~/.dotfiles/bash_functions ~/.bash_functions
ln -s ~/.dotfiles/bash_logout    ~/.bash_logout
ln -s ~/.dotfiles/bash_profile   ~/.bash_profile
ln -s ~/.dotfiles/bashrc         ~/.bashrc
ln -s ~/.dotfiles/crontab        ~/.crontab
ln -s ~/.dotfiles/curlrc         ~/.curlrc
ln -s ~/.dotfiles/cvsignore      ~/.cvsignore
ln -s ~/.dotfiles/gitconfig      ~/.gitconfig
ln -s ~/.dotfiles/inputrc        ~/.inputrc
ln -s ~/.dotfiles/mkshrc         ~/.mkshrc
ln -s ~/.dotfiles/profile        ~/.profile
cd
source .bashrc
cd .dotfiles
cd
git clone http://github.com/johatfie/vim .vim
cd .vim/
git submodule init
git submodule update
g submodule foreach git pull origin master

cd
easy_install-2.7 pip
pip install --upgrade pip
pip install Pygments
easy_install-2.7 pygments

cd repositories/
git clone https://github.com/visionmedia/git-extras.git
cd git-extras/
make install



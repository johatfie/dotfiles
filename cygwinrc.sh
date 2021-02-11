#!/bin/bash

cd
# wget -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
wget -source rawgit.com/kou1okada/apt-cyg/master/apt-cyg > apt-cyg

install apt-cyg /bin

apt-cyg install \
    bash-completion \
    chere \
    cloc \
    cron \
    cscope \
    ctags \
    curl \
    cygutils-extra \
    dos2unix \
    fzf \
    fzf-bash \
    fzf-bash-completion \
    gettext \
    git \
    git-completion \
    git-gui \
    gitk \
    gnupg \
    lynx \
    make \
    moreutils \
    most \
    p7zip \
    procps-ng \
    python38 \
    python38-pip \
    python38-pygments \
    the_silver_searcher \
    tig \
    tmux \
    tree \
    unzip \
    vim \
    xinit \
    xlaunch \
    zip

git clone https://github.com/johatfie/dotfiles .dotfiles
mkdir .dotfiles_orig
mv .bash_profile .dotfiles_orig/
mv .bashrc .dotfiles_orig/
mv .inputrc .dotfiles_orig/
mv .profile .dotfiles_orig/
cd .dotfiles
dos2unix *
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

cd
git clone https://github.com/johatfie/vim .vim
cd .vim/
git submodule init
git submodule update
git submodule foreach git checkout master
git submodule foreach git pull origin master

cd
mkdir repos
cd repos/
git clone https://github.com/visionmedia/git-extras.git
cd git-extras/
make install



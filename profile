# # ~/.profile: executed by the command interpreter for login shells.
# # This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# # exists.
# # see /usr/share/doc/bash/examples/startup-files for examples.
# # the files are located in the bash-doc package.
#
# # the default umask is set in /etc/profile; for setting the umask
# # for ssh logins, install and configure the libpam-umask package.
# #umask 022
#
# export VIM=/usr/share/vim
# export VIMRUNTIME=/usr/share/vim/vim74
# export EDITOR=$VIM/vim
# export VISUAL=/usr/bin/gvim
#
# # # if running bash
# # if [ -n "$BASH_VERSION" ]; then
# #     # include .bashrc if it exists
# #     if [ -f "$HOME/.bashrc" ]; then
# #     . "$HOME/.bashrc"
# #     fi
# # fi
#

if [ -d "$HOME/.bundler_binstubs" ] ; then
    export PATH="~/.bundler_binstubs:$PATH"     # I don't remember what this was for, but now it's enclosed in an if block
fi


echo "Running .profile"

# vim ft=sh

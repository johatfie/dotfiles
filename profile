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
# # 	. "$HOME/.bashrc"
# #     fi
# # fi
#
# # set PATH so it includes user's private bin if it exists
# if [ -d "$HOME/bin" ] ; then
#     PATH="$HOME/bin:$PATH"
# fi
#
#
#
# if [ -d $HOME/.rvm/bin ] ; then
#     export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# fi
#
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#
#
echo "Running .profile"


export PATH=/usr/local/bin:$PATH
export PATH="~/.bundler_binstubs:$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

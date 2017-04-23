# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -ch'

# Misc :)
alias alais=alias
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
alias wget='wget -c'                          # allow resuming downloads
alias h='history'
alias 'h?'='history | grep'
alias clear='printf "\033c"'
alias reload='source ~/.bashrc'
alias cat='pygmentize -g'
alias catln='pygmentize -g -O style=colorful,linenos=1'
# alias vim='mvim -v'
# alias rmvim='mvim -S ~/Session.vim'
# alias o='open -a'
alias 'ps?'='ps_grep'
alias 'alias?'='alias | grep'
alias busy="\cat /dev/urandom | hexdump -C | grep \"ca fe\""
alias virtualbox='sudo virtualbox &'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias ssh_config="\cat ~/.ssh/config.d/* > ~/.ssh/config"
alias jgrep='~/scripts/jgrep'
alias env='env | sort'
alias 'env?'='env | grep'
alias hdel='TMP=$(history | tail -1 | awk "{print $1}") && history -d $TMP'
alias g='git'
alias gc='git commit'
alias gcv='git commit --no-verify'
alias gst='git status'

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# Some shortcuts for different directory listings
alias ls='ls -hFpG'                           # classify files in colour
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
# alias dir='ls --format=vertical'
# alias vdir='ls --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias lal='ls -Al'                            # all but . and ..
alias l='ls -CF'                              #

## get rid of command not found ##
alias cd..='cd ..'

## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias .6='cd ../../../../../'
alias .7='cd ../../../../../../'

## pass options to free ##
alias meminfo='free -m -l -t'

## get top process eating memory
alias psmem='ps aux | sort -nr -k 4'
alias psmem10='ps aux | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps aux | sort -nr -k 3'
alias pscpu10='ps aux | sort -nr -k 3 | head -10'

## Get server cpu info ##
alias cpuinfo='lscpu'

## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##

## get GPU ram on desktop / laptop##
alias gpumeminfo='grep memory /var/log/Xorg.0.log'

# Docker related
alias dm="docker-machine"
alias dm_eval="eval \"\$(docker-machine env dev)\""
alias fig="docker-compose"

echo "Running .bash_aliases"


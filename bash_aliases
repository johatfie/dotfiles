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
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
alias wget='wget -c'                          # allow resuming downloads
alias h='history | grep '
alias clear='printf "\033c"'
alias reload='source ~/.bashrc'
alias cat='pygmentize -g'
alias catln='pygmentize -g -O style=colorful,linenos=1'
alias update='brew update; brew upgrade'
alias vim='mvim -v'
alias rmvim='mvim -S ~/Session.vim'
alias o='open -a'
alias 'ps?'='ps aux | grep'
alias busy="\cat /dev/urandom | hexdump -C | grep \"ca fe\""

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
alias .4='cd ../../../../'
alias .5='cd ../../../../..'


# Mac isms
# alias vim=mvim

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

# Salesforce related
alias dm="docker-machine"
alias fig="docker-compose"
alias restart_docker="docker-compose kill; clear_pids; docker-compose up -d; clear; docker-compose ps"
alias clear_pids="\rm ~/projects/collector/tmp/pids/server.pid; \rm ~/projects/crimsonKraken/tmp/pids/server.pid; \rm ~/projects/silverMonkey/tmp/pids/server.pid; \rm ~/projects/greenHawk/tmp/pids/server.pid"
alias mfa="ssh igo-ssh-gw -fN"
# alias bundle_update="for X in collect blacksquid ck batchelor recs reporting; do docker-compose run \$X bundle install; done"
alias bundle_update="for X in batchelor collect blacksquid ck recs reporting; do echo running docker-compose run \$X bundle install; docker-compose run \$X bundle install; done"
alias snovab="ssh cap@nova-reporting.igodigital.net"
alias tnova="ssh cap@nova-reporting -L 27111:localhost:27017 -N -f"


alias ts1="ssh -L 27101:mongo-1b.stack1.igodigital.net:27017 cap@stack1-recs-0 -f -N"
alias ts2="ssh -L 27102:mongo-1b.stack2.igodigital.net:27017 cap@stack2-recs-0 -f -N"
alias ts3="ssh -L 27103:mongo-1b.stack3.igodigital.net:27017 cap@stack3-recs-0 -f -N"
alias ts4="ssh -L 27104:mongo-1b.stack4.igodigital.net:27017 cap@stack4-recs-0 -f -N"
alias ts5="ssh -L 27105:mongo-1b.stack5.igodigital.net:27017 cap@stack5-recs-0 -f -N"
alias ts6="ssh -L 27106:mongo-1b.stack6.igodigital.net:27017 cap@stack6-recs-2a -f -N"
alias ts7="ssh -L 27107:mongo-1b.stack7.igodigital.net:27017 cap@stack7-recs-0 -f -N"
alias ts8="ssh -L 27108:mongo-1b.stack8.igodigital.net:27017 cap@stack8-recs-0 -f -N"
alias ts9="ssh -L 27109:mongo-1b.stack9.igodigital.net:27017 cap@stack9-recs-0 -f -N"
alias ts10="ssh -L 27110:mongo-1b.stack10.igodigital.net:27017 cap@stack10-recs-0 -f -N"
alias tnova="ssh cap@nova-reporting.igodigital.net -L 27111:localhost:27017 -N -f"
alias ttau="ssh cap@tau-reporting -L 27112:tau-mongo-1b:27017 -f -N"
alias tqa="ssh cap@qa-reporting-services -L 27113:mongo-1a.qa.igodigital.net:27017 -f -N"
alias tstage="ssh cap@reporting.stage.igodigital.net -L 27114:mongo-1a.stage.igodigital.net:27017 -f -N"
alias tmuon="ssh cap@muon-reporting -L 27113:muon-mongo-1b:27017 -f -N"

alias s1b="ssh cap@stack1-reporting"
alias s2b="ssh cap@reporting.stack2.igodigital.net"
alias s3b="ssh cap@reporting.stack3.igodigital.net"
alias s4b="ssh cap@reporting.stack4.igodigital.net"
alias s5b="ssh cap@stack5-reporting"
alias s6b="ssh cap@reporting.stack6.igodigital.net"
alias s7b="ssh cap@reporting.stack7.igodigital.net"
alias s8b="ssh cap@reporting.stack8.igodigital.net"
alias s9b="ssh cap@reporting.stack9.igodigital.net"
alias s10b="ssh cap@reporting.stack10.igodigital.net"
alias smb="ssh cap@muon-reporting.igodigital.net"
alias snb="ssh cap@nova-reporting.igodigital.net"
alias stb="ssh cap@tau-reporting.igodigital.net"
alias sqb="ssh cap@qa-reporting.igodigital.net"
alias suat="ssh cap@uat-reporting.igodigital.net"

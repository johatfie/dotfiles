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
alias 'alias?'='alias | grep'
alias 'ps?'='ps_grep'
alias alais=alias
alias busy="\cat /dev/urandom | hexdump -C | grep \"ca fe\""
alias cat='pygmentize -g'
alias catln='pygmentize -g -O style=colorful,linenos=1'
alias clear='printf "\033c"'
alias egrep='egrep --color=auto'              # show differences in colour
alias env='env | sort'
alias fgrep='fgrep --color=auto'              # show differences in colour
alias g='git'
alias gc='git commit'
alias gcv='git commit --no-verify'
alias grep='grep --color'                     # show differences in colour
alias gst='git status'
alias h?='history | grep'
alias hdel='TMP=$(history | tail -1 | awk "{print $1}") && history -d $TMP'
alias java11='export JAVA_HOME=$(/usr/libexec/java_home -v 11)'
alias jgrep='~/scripts/jgrep'
alias less='less -r'                          # raw control characters
alias o='open -a'
alias reload='source ~/.bash_profile'
alias rmvim='vim -S ~/Session.vim'
alias ssh_config="\cat ~/.ssh/config.d/* > ~/.ssh/config"
alias vim='vim -v'
alias wget='wget -c'                          # allow resuming downloads
alias whence='type -a'                        # where, of a sort
alias winhome='cd `cygpath C:/Users/filis`'

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


# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias alert='terminal-notifier -message "Command finished"; say command finished'

# Appriss specific
alias vault_new='export VAULT_ADDR=https://dbvault.hc.appriss.com'
alias vault_old='export VAULT_ADDR=https://vault.hc.appriss.com'
alias be="bundle exec"
alias kb="kubectl"
alias kx="kubectx"
# alias fhir_pods="kb get pods --all-namespaces | grep fhir"
# alias ca_pods="kb get pods --all-namespaces | grep clinical-alerts"
alias adfs="aws-adfs login --adfs-host=adfs.appriss.com --no-sspi"
alias kube_new="export KUBECONFIG='/Users/jhatfield/.kube/lz_config'"
alias kube_old="export KUBECONFIG='/Users/jhatfield/.kube/config'"
#alias adfs_reset="aws-adfs reset &; unset AWS_DEFAULT_PROFILE &; aws configure --profile 'default'"

alias ca_pods="kb get pods --all-namespaces | awk 'NR == 1 || /clinical-alerts/'"
alias fhir_pods="kb get pods --all-namespaces | awk 'NR == 1 || /fhir/'"

alias kbdpfd="kb delete pod $@ -n fhir-dev"
alias kbdpfq="kb delete pod $@ -n fhir-qa"
alias kbdpcd="kb delete pod $@ -n clinical-alerts-dev"
alias kbdpcq="kb delete pod $@ -n clinical-alerts-qa"
alias kbdpcp="kb delete pod $@ -n clinical-alerts-prep"

alias kblfd="kb logs -f $@ -n fhir-dev -c appriss-fhir-integrator"
alias kblfq="kb logs -f $@ -n fhir-qa -c appriss-fhir-integrator"
alias kblcd="kb logs -f $@ -n clinical-alerts-dev -c clinical-alerts-service"
alias kblcq="kb logs -f $@ -n clinical-alerts-qa -c clinical-alerts-service"
alias kblcp="kb logs -f $@ -n clinical-alerts-prep -c clinical-alerts-service"

# echo "Running .bash_aliases"

# vim ft=sh

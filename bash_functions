
# function settitle
#
settitle ()
{
    echo -ne "\e]2;$@\a\e]1;$@\a";
}

function defaults ()
{
    echo defaults "$@" >> ~/Documents/defaults.txt
    /usr/bin/defaults "$@"
}

# function cd_func
#
# This function defines a 'cd' replacement function capable of keeping,
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
cd_func ()
{
    local x2 the_new_dir adir index
    local -i cnt

    if [[ $1 ==  "--" ]]; then
        dirs -v
        return 0
    fi

    the_new_dir=$1
    [[ -z $1 ]] && the_new_dir=$HOME

    if [[ ${the_new_dir:0:1} == '-' ]]; then
        #
        # Extract dir N from dirs
        index=${the_new_dir:1}
        [[ -z $index ]] && index=1
        adir=$(dirs +$index)
        [[ -z $adir ]] && return 1
        the_new_dir=$adir
    fi


  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  # Now change to the new dir and add to the top of the stack

  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)


  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null


  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
      x2=$(dirs +${cnt} 2>/dev/null)
      [[ $? -ne 0 ]] && return 0
      [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
      if [[ "${x2}" == "${the_new_dir}" ]]; then
          popd -n +$cnt 2>/dev/null 1>/dev/null
          cnt=cnt-1
      fi
  done

  return 0
}

alias cd=cd_func

# function cd_finder_func
#
# Change directory to the current Finder directory
cd_finder_func() {
    target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [ "$target" != "" ]; then
        cd "$target"; pwd
    else
        echo 'No Finder window found' >&2
    fi
}

alias cdf=cd_finder_func


# function man_func
# Get colors in manual pages
man_func ()
{
    \env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

alias man=man_func

ps_grep ()
{
    args=$@;
    ps aux | head -1;
    ps aux | grep "[${args:0:1}]${args:1}";
}

alias ps?=ps_grep


# function cat_color_function
# Syntax highlighting in cat
cat_color_func()
{
    local out colored
    out=$(/bin/cat $@)
    colored=$(echo $out | pygmentize -f console -g 2>/dev/null)
    [[ -n $colored ]] && echo "$colored" || echo "$out"
}

# alias cat=cat_color_func


# bash prompt colorization and git integration
NO_COLOR="\[\033[0m\]"
WHITE="\[\033[1;37m\]"
BLACK="\[\033[0;30m\]"
BLUE="\[\033[0;34m\]"
LIGHT_BLUE="\[\033[1;34m\]"
GREEN="\[\033[0;32m\]"
LIGHT_GREEN="\[\033[1;32m\]"
CYAN="\[\033[0;36m\]"
LIGHT_CYAN="\[\033[1;36m\]"
RED="\[\033[0;31m\]"
LIGHT_RED="\[\033[1;31m\]"
PURPLE="\[\033[0;35m\]"
LIGHT_PURPLE="\[\033[1;35m\]"
YELLOW="\[\033[0;33m\]"
LIGHT_YELLOW="\[\033[1;33m\]"
GRAY="\[\033[1;30m\]"
LIGHT_GRAY="\[\033[0;37m\]"


function prompt_command () {
    branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ "$branch" == "" ]; then
        export PS1="$LIGHT_GREEN\u:$GREEN\w$NO_COLOR "
    else
        export PS1="$LIGHT_GREEN\u:$GREEN\w[$RED$branch$GREEN]$NO_COLOR "
    fi
}

function log_command_to_permanent_history () {
    if [ "$(id -u)" -ne 0 ]; then
        echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log
    fi
}

function combined_prompt () {
    log_command_to_permanent_history
    prompt_command
}

#PROMPT_COMMAND=prompt_command
#export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi';prompt_command
export PROMPT_COMMAND=combined_prompt

function extract {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    else
        if [ -f $1 ] ; then
            # NAME=${1%.*}
            # mkdir $NAME && cd $NAME
            case $1 in
                *.tar.bz2)   tar xvjf ../$1    ;;
                *.tar.gz)    tar xvzf ../$1    ;;
                *.tar.xz)    tar xvJf ../$1    ;;
                *.lzma)      unlzma ../$1      ;;
                *.bz2)       bunzip2 ../$1     ;;
                *.rar)       unrar x -ad ../$1 ;;
                *.gz)        gunzip ../$1      ;;
                *.tar)       tar xvf ../$1     ;;
                *.tbz2)      tar xvjf ../$1    ;;
                *.tgz)       tar xvzf ../$1    ;;
                *.zip)       unzip ../$1       ;;
                *.Z)         uncompress ../$1  ;;
                *.7z)        7z x ../$1        ;;
                *.xz)        unxz ../$1        ;;
                *.exe)       cabextract ../$1  ;;
                *)           echo "extract: '$1' - unknown archive method" ;;
            esac
        else
            echo "$1 - file does not exist"
        fi
    fi
}


# Appriss specific functions

function adfs_reset () {
    echo aws-adfs reset
    aws-adfs reset

    echo unset AWS_DEFAULT_PROFILE
    unset AWS_DEFAULT_PROFILE

    echo aws configure --profile 'default'
    aws configure --profile 'default'
}

function kbecd() {
    kb exec -it $1 -n clinical-alerts-dev -- /bin/bash
}

function kbecq() {
    kb exec -it $1 -n clinical-alerts-qa -- /bin/bash
}

function kbefd() {
    kb exec -it "$1" -n fhir-dev -- /bin/bash
}

function kbefq() {
    kb exec -it "$1" -n fhir-qa -- /bin/bash
}

function kbeid() {
    kb exec -it "$1" -n interconnect-dev -- /bin/bash
}

function kbenrd() {
    kb exec -it $1 -n pmp-dev -- /bin/bash
}

function kbenrq() {
    kb exec -it $1 -n pmp-qa -- /bin/bash
}

function asp()
{

    if [ -n "$AWS_CONFIG_FILE" ]; then
        local conf_file=$AWS_CONFIG_FILE
    else
        local conf_file=~/.aws/config-i2
    fi

    if [ -z "$1" ]; then
        local p=$(\cat "$conf_file" | grep '\[profile' | sed -n 's/\[profile \(.*\).*\]/\1/p' | fzf)
    else
        local p=$1
    fi

    if [ $? -eq 0 ] && [ -n "$p" ]; then
        echo "Setting AWS profile to $p"
        export AWS_EB_PROFILE="$p"
        export AWS_DEFAULT_PROFILE="$p"
        export AWS_PROFILE="$p"
    else
        echo "Unsetting AWS profile"
        unset AWS_EB_PROFILE
        unset AWS_DEFAULT_PROFILE
        unset AWS_PROFILE
    fi
}

_asp_completions()
{
    if [ -n "$AWS_CONFIG_FILE" ]; then
        local conf_file=$AWS_CONFIG_FILE
    else
        local conf_file=~/.aws/config-i2
    fi

    _PROFILES=$(\cat "$conf_file" | grep '\[profile' | sed -n 's/\[profile \(.*\).*\]/\1/p')
      COMPREPLY=($(compgen -W "${_PROFILES}" -- "${COMP_WORDS[1]}"))
}

complete -F _asp_completions asp


# echo "Running .bash_functions"

# vim ft=sh

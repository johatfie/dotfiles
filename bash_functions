
# function settitle
#
function settitle ()
{
    git_root="$(basename $(git rev-parse --show-toplevel 2>/dev/null) 2>/dev/null)"

    if [[ $git_root != '' ]]; then
        echo -ne "\033];${git_root}\007"
    else
        echo -ne "\033];${PWD##*/}\007"
    fi
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

    #the_new_dir=$1
    the_new_dir=$(echo $1 | sed 's/#.*//g')
    #echo "$the_new_dir"

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

    # if using iTerm2, set the title
#     if [ $ITERM_SESSION_ID ]; then
        settitle
#     fi

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

#alias cdf=cd_finder_func


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

# alias man=man_func

ps_grep ()
{
    args=$@;
    ps aux | head -1;
    ps aux | grep [${args:0:1}]${args:1};
}

alias ps?=ps_grep


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

alias cat=cat_color_func


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
    history -a

    branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`

    if [ "$branch" == "" ]; then
        export PS1="$LIGHT_GREEN\u:$GREEN\w$NO_COLOR "
    else
        export PS1="$LIGHT_GREEN\u:$GREEN\w[$RED$branch$GREEN]$NO_COLOR "
    fi
}

function log_command_to_permanent_history () {
    mkdir ~/.logs 2> /dev/null

#     if [ "$(id -u)" -ne 0 ]; then
        echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log
#     fi
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

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
    local branches branch
    branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
        branch=$(echo "$branches" |
            fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
            git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fd - cd to selected directory
fd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
}


# fdr - cd to selected parent directory
fdr() {
    local declare dirs=()
    get_parent_dirs() {
        if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
        if [[ "${1}" == '/' ]]; then
            for _dir in "${dirs[@]}"; do echo $_dir; done
        else
            get_parent_dirs $(dirname "$1")
        fi
    }

    local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
    cd "$DIR"
}


# cdf - cd into the directory of the selected file
cdf() {
    local file
    local dir
    file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

v() {
  local files
  files=$(grep '^>' ~/.vim/viminfo | cut -c3- |
          while read line; do
            [ -f "${line/\~/$HOME}" ] && echo "$line"
          done | fzf-tmux -d -m -q "$*" -1) && vim ${files//\~/$HOME}
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
    local out q k sha
    while out=$(
        git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
        fzf --ansi --no-sort --query="$q" --print-query \
            --expect=ctrl-d,ctrl-b);
    do
        mapfile -t out <<< "$out"
        q="${out[0]}"
        k="${out[1]}"
        sha="${out[-1]}"
        sha="${sha%% *}"
        [[ -z "$sha" ]] && continue

        if [[ "$k" == 'ctrl-d' ]]; then
            git diff $sha
        elif [[ "$k" == 'ctrl-b' ]]; then
            git stash branch "stash-$sha" $sha
            break;
        else
            git stash show -p $sha
        fi
    done
}

# Setup cdg function
# ------------------
# https://dmitryfrank.com/articles/shell_shortcuts
unalias cdg 2> /dev/null
cdg() {
   local dest_dir=$(cdscuts_glob_echo | fzf )
   if [[ $dest_dir != '' ]]; then
      cd $dest_dir
   fi
}
export -f cdg > /dev/null

cdg-add () {
    local curr_dir="${PWD} # $*"
    if ! grep -Fxq "$curr_dir" ~/.cdg_paths; then
        echo "$curr_dir" >> ~/.cdg_paths
    fi
}




# echo "Running .bash_functions"

# vim ft=bash

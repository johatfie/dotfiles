
# function settitle
#
settitle ()
{
    echo -ne "\e]2;$@\a\e]1;$@\a";
}

function defaults ()
{ echo defaults "$@" >> ~/Documents/defaults.txt
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
    env \
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


# This is intended to just run all the things that tend to fix normal docker issues - are there more?
fix_docker()
{
    sudo route -n add -net $(docker-machine ip dev)/24 -interface $(VBoxManage showvminfo dev --machinereadable | grep hostonlyadapter | cut -d '"' -f 2)
    eval $(docker-machine env dev)
}

# helper function, turns pwd into a docker exec (where possible)
docker_command()
{
    PROJ=${PWD##*/}
    PROJ=$(echo "$PROJ" | tr '[:upper:]' '[:lower:]')

    if [ "$PROJ" = "cie" ]
    then
        COMMAND="docker-compose -f ../cobaltStarfish/docker-compose.yml run cie"
    elif [ "$PROJ" = "silvermonkey" ]
    then
        COMMAND="docker exec -it cobaltstarfish_recs_1"
    elif [ "$PROJ" = "collector" ]
    then
        COMMAND="docker exec -it cobaltstarfish_collect_1"
    elif [ "$PROJ" = "greenhawk" ]
    then
        COMMAND="docker exec -it cobaltstarfish_reporting_1"
    else
        COMMAND="docker exec -it cobaltstarfish_${PROJ}_1"
    fi
}

# Use right in the project directory, no need to specify
# Example src/cie> run rake test
run()
{
    docker_command
    RUN_COMMAND="$COMMAND bundle exec $*"
    echo $RUN_COMMAND
    $RUN_COMMAND
}

# bundler helper, infers project from directory
dobundle()
{
    docker_command
    BUNDLE_COMMAND="$COMMAND bundle"
    echo $BUNDLE_COMMAND
    $BUNDLE_COMMAND
}

# just run rubocop on the current project
rubocop()
{
    docker_command
    $COMMAND bundle exec rake rubocop_git
}

# run tests without rubocop:
# you must specify a test file!
# dotest test/functional/some_controller_test.rb
# dotest test/functional/some_controller_test.rb -n /pattern.matching.one.test/
dotest()
{
    docker_command
    TEST_COMMAND="$COMMAND bundle exec ruby -I"lib:test" $*"
    echo $TEST_COMMAND
    $TEST_COMMAND
}

# open batchelor cli from anywhere
cli()
{
    docker exec -ti cobaltstarfish_batchelor_1 ./batchelor_cli console
}

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

PROMPT_COMMAND=prompt_command

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


echo "Running .bash_functions"

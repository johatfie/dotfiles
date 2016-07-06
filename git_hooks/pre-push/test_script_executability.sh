#!/usr/bin/env bash

function run_test {

    root_dir="$HOME/projects/batchelor"
    declare -a non_executable_scripts

    for file in $root_dir/cron_scripts/**/*.sh ; do
        if [[ ! -x "$file" ]]; then
            non_executable_scripts=("${non_executable_scripts[@]}" "$file")
        fi
    done

    if [[ ${#non_executable_scripts[@]} -eq 0 ]]; then
        echo "All cron scripts marked executable"
        exit 0
    else
        echo "These scripts are not marked executable"

        for file in "${non_executable_scripts[@]}"
        do
          echo "${file#$root_dir/}"
        done

        exit 1
    fi
}

case "${1}" in
    --about )
        echo "Check executability of all the cron scripts"
        ;;
    * )
        run_test
        ;;
esac

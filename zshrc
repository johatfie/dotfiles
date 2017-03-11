
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

echo "Running .zshrc\n"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/usr/home/jon/.sdkman"
[[ -s "/usr/home/jon/.sdkman/bin/sdkman-init.sh" ]] && source "/usr/home/jon/.sdkman/bin/sdkman-init.sh"

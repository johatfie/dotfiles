
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

echo "Running .zshrc\n"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault

iwr -useb get.scoop.sh | iex
scoop bucket add extras
scoop install caffeine
scoop install vim
scoop install cygwin
scoop install conemu
scoop install gtools
scoop install flux
scoop install coreutils
scoop install less
scoop install which

setx PROMPT $E[1;36m[%username%@%computername%]:$E[1;35m$P$S$+$G$S$E[1;37m

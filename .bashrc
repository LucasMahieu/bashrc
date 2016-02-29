echo "Hello .bashrc"
# The orginal version is saved in .bash_profile.pysave
#PYTHONPATH="~/PHELMA/Freescale/distantIO/DistantIO:${PYTHONPATH}"
#export PYTHONPATH

PYTHONPATH="/usr/local/Cellar/pyqt/4.11.4/lib/python3.5/site-packages/:${PYTHONPATH}"
PYTHONPATH="/usr/local/Cellar/python3/3.5.1/bin/:${PYTHONPATH}"
export PYTHONPATH
#export PYTHONPATH=/usr/local/Cellar/pyqt/4.11.4/:$PYTHONPATH

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
#export PATH

PATH=$PATH:/usr/local/gnat/bin
export PATH

# Pour Projet GL#
export PATH=$HOME/ENSIMAG_2A/PGL/GL/global/bin:$PATH
export PATH=$HOME/ENSIMAG_2A/PGL/Projet_GL/src/main/bin:$PATH
export PATH=$HOME/ENSIMAG_2A/PGL/Projet_GL/src/test/script:$PATH
export PATH=$HOME/ENSIMAG_2A/PGL/Projet_GL/src/test/script/launchers:$PATH

#export PATH="$PATH:/opt/toto/bin"
#########################################################
####### Lustre #########
export LUSTRE_INSTALL=/usr/local/lustre-v4-III-c-macosx
source $LUSTRE_INSTALL/setenv.sh

################ check for an interactive session##############
[ -z "$PS1" ] && return


#####################OTHER OPTION FROM LINUX#################

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias rgrep='rgrep --color=auto'
fi


######## LISTE DES ALIAS #########

alias ls='ls -GF'
alias ll='ls -a -l -h -F'
alias la='ls -aF'
alias lla='ls -AlFh'
alias clr='clear'

## .tar ##
alias tarx='tar -zxvf'
alias tarc='tar -zcvf'

#alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias vim='mvim -v'

# Hombrew ctags
alias ctags="`brew --prefix`/bin/ctags"

#texshop
alias texshop="/Applications/TeX/TeXShop.app/Contents/MacOS/TeXShop "
alias marko="/Applications/Marko.app/Contents/MacOS/Marko "

################## auto completio GIT ##################
# pour l'ajout de l'auto-completion de git
# d'apres : http://git-scm.com/book/fr/v1/Les-bases-de-Git-Trucs-et-astuces
source ~/.git-completion.sh
#PS1='\u:\w$(__git_ps1"(%s)")\$'

############# PROMPT ###################

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
  tput sgr0
  if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
    # Changed these colors to fit Solarized theme
    MAGENTA=$(tput setaf 125)
    ORANGE=$(tput setaf 166)
    GREEN=$(tput setaf 64)
    PURPLE=$(tput setaf 61)
    WHITE=$(tput setaf 244)
  else
    MAGENTA=$(tput setaf 5)
    ORANGE=$(tput setaf 4)
    GREEN=$(tput setaf 2)
    PURPLE=$(tput setaf 1)
    WHITE=$(tput setaf 7)
  fi
  BOLD=$(tput bold)
  RESET=$(tput sgr0)
else
  MAGENTA="\033[1;31m"
  ORANGE="\033[1;33m"
  GREEN="\033[1;32m"
  PURPLE="\033[1;35m"
  WHITE="\033[1;37m"
  BOLD=""
  RESET="\033[m"
fi

export MAGENTA
export ORANGE
export GREEN
export PURPLE
export WHITE
export BOLD
export RESET


function parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

export PS1="\[${BOLD}${MAGENTA}\]\u\[$WHITE\]@\[$ORANGE\]\h\[$WHITE\]>\[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\$ \[$RESET\]"
export PS2="\[$ORANGE\]→ \[$RESET\]"

############## PS1  ######################
#PS1='\e[32m\u:\e[33m\w\e[00m\$> '

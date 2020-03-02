# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
ZSH_DISABLE_COMPFIX="true"
# Path to your oh-my-zsh installation.
export ZSH="/home/zcp/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  autojump
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias ofv19='source $HOME/OpenFOAM/OpenFOAM-v1906/etc/bashrc ; echo "OpenFOAMv1906 is enabled."'
alias of40='source $HOME/OpenFOAM/OpenFOAM-4.0/etc/bashrc WM_LABEL_SIZE=64 FOAMY_HEX_MESH=yes; echo "OpenFOAM-4.0 is enabled."'
alias of5='source /opt/openfoam5/etc/bashrc; echo "OpenFOAM-5 is enabled."'
alias of7='source /opt/openfoam7/etc/bashrc; echo "OpenFOAM-7 is enabled."'
alias ofdev='source /opt/openfoam-dev/etc/bashrc; echo "OpenFOAM-dev is enabled."'
alias of2='source $HOME/OpenFOAM/OpenFOAM-2.2.0/etc/bashrc; echo "OpenFOAM-2.2 is enabled."'
export PATH=”$PATH:export PATH="$PATH:/usr/local/MATLAB/R2018b/bin/"
#切换openfoam版本：
# source $HOME/OpenFOAM/OpenFOAM-v1906/etc/bashrc
 source /opt/openfoam-dev/etc/bashrc
#source /opt/openfoam5/etc/bashrc
alias of18='source $HOME/OpenFOAM/OpenFOAM-v1806/etc/bashrc '

#JDK-8
export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_231 ## 这里要注意目录要换成自己解压的jdk 目录
export JRE_HOME=${JAVA_HOME}/jre  
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib  
export PATH=${JAVA_HOME}/bin:$PATH  


export PATH=”$PATH:export PATH="$PATH:/home/zcp/DAKOTA/dakota_installation/bin"
export PATH=”$PATH:export PATH="$PATH:/home/zcp/Desktop/Hexo_Site/node_modules/.bin"

#  自定义快捷键
alias st="cmd.exe /c start"
alias q="exit"

alias gcl="git clone"
alias gs="git status"
alias gac="git add -A;git commit -m"
alias gp="git push"
alias gc="git checkout"
alias gb="git branch"
alias gbc="git checkout -b"

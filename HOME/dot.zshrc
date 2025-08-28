# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#if [ -f "/opt/python-3.14.0/bin/python3" ]; then
#    export PATH="/opt/python-3.14.0/bin:$PATH"
#fi
source $HOME/py3.12.4/.venv/bin/activate

###   #### >>> conda initialize >>>
###   #### !! Contents within this block are managed by 'conda init' !!
###   __conda_setup="$("${HOME}/anaconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
###   if [ $? -eq 0 ]; then
###       eval "$__conda_setup"
###   else
###       if [ -f "${HOME}/anaconda3/etc/profile.d/conda.sh" ]; then
###           . "${HOME}/anaconda3/etc/profile.d/conda.sh"
###       else
###           export PATH="${HOME}/anaconda3/bin:$PATH"
###       fi
###   fi
###   unset __conda_setup
###   # <<< conda initialize <<<
###   
###   conda activate py3.8.10-iotedge

set -o vi
alias indent='clang-format -style="{BasedOnStyle: llvm, IndentWidth: 4, BreakBeforeBraces: Custom, BraceWrapping: {AfterClass: true, AfterStruct: true, AfterControlStatement: false, AfterFunction: true, BeforeElse: true}}"'
#alias fd='fdfind --hidden  --no-ignore'
alias fd='fdfind --hidden  --no-ignore'
export PATH="$HOME/.local/bin:$PATH"

alias bat='batcat'

if [[ $(lsb_release -rs) == "20.04" ]]; then
    FCITX=fcitx
    alias open='xdg-open'
    alias meld='flatpak run org.gnome.meld'
else
    FCITX=fcitx5
fi
export XMODIFIERS=@im=$FCITX
export GTK_IM_MODULE=$FCITX
export QT_IM_MODULE=$FCITX

if ip route | grep -q 10.0.96.0; then # Office
    export HOST_118=10.0.110.118
    export RSYNC="rsync -e 'ssh -p2231'"
    export REMOTE_DEV_HOST=h.liuxr.net
else # Home
    export HOST_118=20.0.0.118
    export RSYNC=rsync
    export REMOTE_DEV_HOST=20.0.0.2
fi
export DS63_BUILD_HOST=$HOST_118
alias j='ssh buspas@10.0.110.6'
alias 4g='ssh buspas@$HOST_118'


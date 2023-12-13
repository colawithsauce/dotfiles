# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="jovial"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
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
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

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
plugins=(
  # zsh-history-enquirer

  git
  # autojump
  extract
  # urltools
  # bgnotify
  zsh-autosuggestions
  zsh-syntax-highlighting
  jovial
)

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:~/.config/emacs/bin

# export all_proxy=http://127.0.0.1:7890
# export http_proxy=http://127.0.0.1:7890
# export https_proxy=http://127.0.0.1:7890

export PATH=$PATH:~/.local/bin:/opt/cuda/extras/compute-sanitizer

# rust
export PATH=$PATH:~/.cargo/bin:~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin

# alias python=pypy3
# alias pip="pypy3 -m pip"

alias s=sdcv
alias rm=trash
alias neofetch=fastfetch
alias k="sudo systemctl start sddm"
alias nok="sudo systemctl stop sddm"
alias g="sudo systemctl start gdm"
alias nog="sudo systemctl stop gdm"
alias a="tmux a || tmux"

alias mg="emacsclient --eval \"(magit)\" -t"
e() {
  emacs -nw "$@" 2>/dev/null
}

# Emacs alias
c() {
  if [[ "$1" == "-" ]]; then # Pipeline
    TMP="$(mktemp /tmp/stdin-XXX)"
    cat >$TMP
    emacsclient -a "emacs -nw" $TMP -t 2>/dev/null
    rm $TMP
  elif [[ $# == 0 ]]; then # without argument, open current directory
    emacsclient -a "emacs -nw" . -t 2>/dev/null
  else
    emacsclient -a "emacs -nw" "$@" -t 2>/dev/null
  fi
}

# Test if terminal is in emacs terminal
term_in_emacs () {
  if [[ "$TERMINFO" == *"emacs"* ]]; then
    return 0 # True
  else
    return 1 # False
  fi
}

# if call without argument, call `nvim .`; else call nvim with all its arguments
vi () {
    term_in_emacs && echo "It's in Emacs! WHAT THE HELL ARE YOU DOING?" && return
    # if [ $# -eq 0 ]; then
    #     nvim .
    # else
    #     nvim $@
    # fi
    nvim $@
}

# Sudo version of vi()
vis () {
    term_in_emacs && echo "It's in Emacs! WHAT THE HELL ARE YOU DOING?" && return
    if [ $# -eq 0 ]; then
        sudo -E nvim .
    else
        sudo -E nvim $@
    fi
}

# GUI version of vi()
vig ()
{
    if [ $# -eq 0 ]; then
        neovide .
    else
        neovide $@
    fi
}

export LANG=en_US.UTF-8

# User configuration -- https://unix.stackexchange.com/questions/629783/how-can-i-change-cursor-shape-in-tty
if [ -z "${TERMINFO}" ]; then
    echo -e '\033[?17;0;64c'
    # printf '\033[?112c'
    alias x="startx"
    alias h="exec Hyprland"
fi

# Mail noticing
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Only show important messages
if [[ "$(notmuch count tag:important and not tag:confirmed)" != 0 ]]; then
    echo -e "There are ${CYAN}`notmuch count tag:important`${NC} unread IMPORTANT mails here:"
    notmuch search tag:important and not tag:confirmed
fi

confirm_important() {
  notmuch tag +confirmed tag:important
}

check_concerned() {
  notmuch tag -concerned +checked tag:concerned
}

# export MANPATH="/usr/local/man:$MANPATH"
export TERM=xterm-256color

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ESP32 Environment
alias get_idf=". $HOME/Projects/esp/esp-idf/export.sh"

# This is for unexpected scenarios only.
# In general mason should install these X-platform

#                  config.fish                  #
#               Vimacs Mason PATH               #
export PATH=$PATH:"$HOME/.local/share/nvim/mason/bin"
export PATH=$PATH:"$HOME/.local/share/gem/ruby/3.0.0/bin"

# HIPCC
# export PATH=$PATH:"/opt/rocm/bin"

# mails
sync_mail () {
  echo "Date: `date`" >> /tmp/mail.log && mbsync --all >> /tmp/mail.log 2>&1 && notmuch new >> /tmp/mail.log 2>&1 && afew -tn >> /tmp/mail.log 2>&1
}


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
eval "$(direnv hook zsh)"
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi

export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper_lazy.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# customization
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
setopt nocorrectall
export PATH=$PATH:$HOME/bin

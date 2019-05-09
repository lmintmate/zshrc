HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000

#autoinstall the agkozak zsh prompt
if [[ ! -d ~/agkozak-zsh-prompt ]]; then
  git clone https://github.com/agkozak/agkozak-zsh-prompt ~/agkozak-zsh-prompt
fi
#source it
source ~/agkozak-zsh-prompt/agkozak-zsh-prompt.plugin.zsh

AGKOZAK_LEFT_PROMPT_ONLY=1

function man() {
	env \
		LESS_TERMCAP_md=$(tput bold; tput setaf 1) \
		LESS_TERMCAP_me=$(tput sgr0) \
		LESS_TERMCAP_mb=$(tput bold; tput setaf 2) \
		LESS_TERMCAP_us=$(tput bold; tput setaf 2) \
		LESS_TERMCAP_ue=$(tput rmul; tput sgr0) \
		LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) \
		LESS_TERMCAP_se=$(tput rmso; tput sgr0) \
		PAGER="${commands[less]:-$PAGER}" \
		man "$@"
}

bindkey -e

case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;%~\a"}
        ;;
esac

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

setopt list_rows_first

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

setopt auto_cd

setopt histignoredups

setopt ignoreeof

setopt correct_all

autoload -U colors && colors
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r?$reset_color (Yes, No, Abort, Edit) "

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -lh'
alias la='ls -lah'
alias termclock="tty-clock -b -c -C 6 -f \"%A %d/%m/%y\" -B -a 100000000 -d 0"

export MICRO_TRUECOLOR=1
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000

if [[ ! -d ~/.zinit ]];then
mkdir ~/.zinit
git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh

zinit ice wait"2" lucid as"program" cp"color.zsh -> color" pick"color"
zinit light molovo/color

zinit ice wait"2" lucid as"program" mv"revolver.zsh-completion -> _revolver" pick"revolver"
zinit light molovo/revolver

zinit ice wait"2" lucid as"program" mv"zvm.zsh-completion -> _zvm" pick"zvm" src"zvm-shell-integration.zsh"
zinit light molovo/zvm

zinit light psprint/zsh-cmd-architect

zinit light agkozak/agkozak-zsh-prompt

zinit light MichaelAquilina/zsh-auto-notify

zinit light MichaelAquilina/zsh-you-should-use

zinit light RobSis/zsh-completion-generator

AGKOZAK_LEFT_PROMPT_ONLY=1

AUTO_NOTIFY_IGNORE+=("micro")
AUTO_NOTIFY_IGNORE+=("mocp")

export YSU_MESSAGE_POSITION="after"

export LESS_TERMCAP_md=$(tput bold; tput setaf 1)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
export LESS_TERMCAP_us=$(tput bold; tput setaf 2)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)

bindkey -e

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

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

autoload -Uz history-beginning-search-menu-space-end history-beginning-search-menu
zle -N history-beginning-search-menu-space-end history-beginning-search-menu
bindkey "^H" history-beginning-search-menu-space-end

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

mkcd() { mkdir "$1"; cd "$1"; }

x-kill-whole-line () {
  zle kill-whole-line
  print -rn $CUTBUFFER | xsel -i -b
}
zle -N x-kill-whole-line

x-yank () {
  CUTBUFFER=$(xsel -o -b </dev/null)
  zle yank
}
zle -N x-yank

bindkey -e '^U' x-kill-whole-line
bindkey -e '^Y' x-yank

zmodload -i zsh/parameter

insert-last-command-output() {
  LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N insert-last-command-output

bindkey "^Q" insert-last-command-output

case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;%~\a"}
        preexec () {print -Pn "\e]0;$1\a"}
        ;;
esac

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

setopt list_rows_first

setopt glob_complete

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

setopt auto_cd

setopt inc_append_history

setopt histignoredups

setopt ignoreeof

unsetopt flowcontrol

setopt correct_all

autoload -U colors && colors
export SPROMPT="Correct $fg_bold[red]%R$reset_color to $fg_bold[green]%r?$reset_color ($fg_bold[green]Yes$reset_color, $fg_bold[yellow]No$reset_color, $fg_bold[red]Abort$reset_color, $fg_bold[blue]Edit$reset_color) "

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -lh'
alias la='ls -lah'
alias gs='git status'
alias zstatus='zinit zstatus'
alias termclock="tty-clock -b -c -C 6 -f \"%A %d/%m/%y\" -B -a 100000000 -d 0"

alias \$=''
alias \%=''

export LESS=-R

export MICRO_TRUECOLOR=1

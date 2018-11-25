# iv597's ZSH configuration
# Maintained 2012-17 (and counting)
# Released under the [Unlicense](http://unlicense.org/)

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory autocd beep extendedglob notify promptsubst hist_ignore_dups hist_ignore_space noflowcontrol
bindkey -v # You can't stop here, you're in Vim country!...
zstyle :compinstall filename '/home/j/.zshrc'

fpath+=~/.zfunc

autoload -Uz compinit && compinit
autoload -U colors && colors

zstyle ':completion:*' menu select

# zmv -  a command for renaming files by means of shell patterns.
autoload -U zmv

# Control-x-e to open current line in $EDITOR, awesome when writting functions or editing multiline commands.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Fix for tmux on linux.
case "$(uname -o)" in
	'GNU/Linux')
		export EVENT_NOEPOLL=1
	;;
esac

source /usr/share/fzf/key-bindings.zsh

sprunge() {
	curl -F sprunge=@- sprunge.us
}

sprup() {
	cat $1 | sprunge
}

setopt PROMPT_SUBST

source /usr/share/git/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1

export PROMPT="(%m) %c %F{cyan} \$(__git_ps1 '» %s ')» %{$reset_color%}%"

precmd() { print "" }

eval "$(pipenv --completion)"
eval "$(direnv hook zsh)"
eval $(dircolors ~/.dir_colors)

setopt no_complete_aliases

alias e='nvim'
alias vim='nvim'

alias pf='aurman -Ss'
alias pi='aurman -S'
alias pii='aurman -Sy'
alias pu='aurman -Syu'
alias pql='pacman -Ql'
alias pqs='pacman -Qs'

alias mp='makepkg -icsr'

alias sudo='sudo -E '

alias df='df -h -x devtmpfs -x rootfs -x tmpfs' # hide all these Arch-standard FSes

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

alias chmod="chmod -c"
alias chown="chown -c"

alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'

alias ls='ls --color=auto --human-readable --group-directories-first --classify'
alias tree='tree -CA'

alias git="echo UPDATESTARTUPTTY | gpg-connect-agent >/dev/null && /usr/bin/git"
alias gitlog="git log --format='%Cred%h%Creset %s %Cgreen(%cr) %C(blue)<%an>%Creset%C(yellow)%d%Creset' --no-merges"
alias gitlogsprint="gitlog --since '2 weeks' --author 'Josh Klar'"

alias gl="gitlog"
alias gls="gitlogsprint"
alias gca="git commit --amend --no-edit"

if command -v colordiff > /dev/null 2>&1; then
	alias diff="colordiff -Nuar"
else
	alias diff="diff -Nuar"
fi

alias poetry="/usr/bin/python -m poetry"
alias poetry2="/usr/bin/python2 -m poetry"

zstyle ':completion:*:sudo::' environ PATH="/sbin:/usr/sbin:$PATH" HOME="/root"

bindkey "^[[H" beginning-of-line #Home key
bindkey "^[[F" end-of-line #End key
bindkey "^[[3~" delete-char #Del key
bindkey "^[[A" history-beginning-search-backward #Up Arrow
bindkey "^[[B" history-beginning-search-forward #Down Arrow
bindkey "^[Oc" forward-word # control + right arrow
bindkey "^[Od" backward-word # control + left arrow
bindkey "^H" backward-kill-word # control + backspace
bindkey "^[[3^" kill-word # control + delete

export PATH=/home/j/.local/bin:$PATH

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/j/src/lumen/healthchecker/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/j/src/lumen/healthchecker/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/j/src/lumen/healthchecker/node_modules/tabtab/.completions/sls.zsh ]] && . /home/j/src/lumen/healthchecker/node_modules/tabtab/.completions/sls.zsh
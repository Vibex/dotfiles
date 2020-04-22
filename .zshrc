### Set Defaults
export EDITOR="/bin/vim"
#export VISUAL="/bin/gvim"


### Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.


### Completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=500
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

### History
setopt appendhistory                                            # Immediately append history instead of overwriting


### Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                      # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     # Skip forward a word with ctrl+right
bindkey '^[Od' backward-word                                    # Skip backward a word with ctrl+left
bindkey '^[[1;5C' forward-word                                  # Skip forward a word with ctrl+right
bindkey '^[[1;5D' backward-word                                 # Skip backward a word with ctrl+left
bindkey '^H' backward-kill-word                                 # Delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Undo last action with shift+tab


### Alias section
alias fin="cd; clear"											# Clean up after finishing a task
alias cp="cp -i"												# Confirm before overwriting something
alias df='df -h'												# Human-readable sizes
alias free='free -m'											# Show sizes in MB
alias ls='ls --color=auto'										# Auto color ls output
alias lsa='ls -A'												# Show hidden files
alias lsl='ls -l -h'											# Show long file format (with human readable sizes)
alias lsla='ls -A -l -h'										# Show long file format (with human readable sizes) and include hidden
alias pingg='ping google.com -c3'								# Test internet connection
alias wifi-check='nmcli device wifi rescan && nmcli device wifi list'	# rescan local network and print out list
alias orphan-kill='sudo pacman -Rns $(pacman -Qtdq)' 			# Remove orphaned packages with pacman
alias yay-orphan-kill='yay -Rns $(yay -Qtdq)'					# Remove orphaned packages with yay
alias xm='xrdb -merge "$HOME/.Xresources"'						# Reload .Xresources
alias xs='pkill -USR1 -x sxhkd'									# Reload sxhkd conf
alias vvim='vim'												# My v key was broken for a while
alias endx='pkill -9 Xorg'										# Force Kill Xorg
alias xsnow='xsnow -notrees -nosanta'							# Have some fun in the winter

# Alias/Functions
# Make a new directory and cd into it
mkcd() { 
	mkdir -p "$1" && cd "$1"; 
}

# Swap two files 
swap() { 
	local TMPFILE=tmp.$$;
	mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE "$2";
}


### Plugins section: Enable fish style features
# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# Use autosuggestion
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down


###  Colours
autoload -U compinit colors zcalc
compinit -d
colors

## Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r


### Git Integration
# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_AHEAD="%{$fg[blue]%}+NUM"		# A"NUM"         - ahead by "NUM" commits
GIT_PROMPT_BEHIND="%{$fg[magenta]%}-NUM"	# B"NUM"         - behind by "NUM" commits
GIT_PROMPT_MERGING="%{$fg_bold[cyan]%}⚡︎"	# lightning bolt - merge conflict
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●"	# red circle     - untracked files
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●"	# yellow circle  - tracked files modified
GIT_PROMPT_STAGED="%{$fg_bold[green]%}●"	# green circle   - staged changes present = ready for "git push"

# Check the git state and produce a status line for it based off of the variables above
parse_git_state() {
	# Show different symbols as appropriate for various Git repository states
	local GIT_STATE=""
	if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
		GIT_STATE="$GIT_STATE$GIT_PROMPT_UNTRACKED"
	fi
	if ! git diff --quiet 2> /dev/null; then
		GIT_STATE="$GIT_STATE$GIT_PROMPT_MODIFIED"
	fi
	if ! git diff --cached --quiet 2> /dev/null; then
		GIT_STATE="$GIT_STATE$GIT_PROMPT_STAGED"
	fi
	
	local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
	local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
	if [[ "$NUM_AHEAD" -gt 0 ]]; then 
		if [[ -n $GIT_STATE ]]; then
			GIT_STATE="$GIT_STATE "
		fi
		GIT_STATE="$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}"
	fi
	if [[ "$NUM_BEHIND" -gt 0 ]]; then 
		GIT_STATE="$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}"
	fi
	
	local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
	if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
		GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
	fi

	if [[ -n $GIT_STATE ]]; then
		echo " $GIT_STATE"
	fi
}

# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
	( git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD ) 2> /dev/null
}

# Generate the git prompt using the two functions above (and error information)
git_prompt_string() {
	local git_where="$(parse_git_branch)"

	# If inside a Git repository, print its branch and state
	if [ -n "$git_where" ]; then
		echo -n "%{$bg[black]%}$(parse_git_state) %{$reset_color%}%{$bg[black]%}${git_where#(refs/heads/|tags/)} " 
	fi
	# Print exit codes of last command (only if it failed)
	echo "%(?..%{$bg[red]%} %? )%{$reset_color%}"
}

### Prompt
# enable substitution for prompts
setopt prompt_subst

# Print a host title card
clear
echo "$bg_bold[magenta] $HOST $reset_color"

# Left Prompt
#  - Shows if user is superuser with colored box (Green No, Red Yes)
#  - Followed by current dir which is colored if last command returned an error (Blue No, Red Yes)
#PROMPT="%(!.%{$bg_bold[red]%}.%{$bg_bold[green]%}) %# %(?.%{$bg_bold[cyan]%}.%{$bg_bold[red]%}) %1/%u %b%{$reset_color%} "
PROMPT="%(!.%{$bg_bold[yellow]%}.%{$bg_bold[green]%})   %(?.%{$bg_bold[blue]%}.%{$bg_bold[red]%}) %1/%u %b%{$reset_color%} "

## Right Prompt
#  - shows status of git when in git repository (code adapted from https://techanic.net/2012/12/30/my_git_prompt_for_zsh.html)
#  - shows exit status of previous command (if previous command finished with an error)
#  - is invisible, if neither is the case
RPROMPT='$(git_prompt_string)'
#RPROMPT='%{$bg_bold[black]%} %2~%u %{$reset_color%}'



### Hooks
autoload -Uz add-zsh-hook
do-ls() {
	emulate -L zsh; ls;
}
# ls after every directory change
add-zsh-hook chpwd do-ls

# Automatically change window title and print a blank line after prompt loads
function xterm_title_precmd () {
	print ""
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}
# Automatically change window title and print a blank line before executing command (blank line disabled for now)
function xterm_title_preexec () {
	#print ""
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

# Add window rename hooks
if [[ "$TERM" == (alacritty*|gnome*|konsole*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

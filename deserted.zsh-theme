#!/usr/bin/env zsh

# Set User color
USERCOLOR=$fg[green]

# See if user is root
if [[ "$USER" == "root" ]]; then ROOTPREFIX="⚡️ " && USERCOLOR=$fg[red] ; else ROOTPREFIX="" ; fi

# Sets prompt arrow color based on if last command failed or not
local PROMPT_ARROW="%(?,%{$fg_bold[yellow]%}~>,%{$fg_bold[red]%}~>)"

# Set prefix
local USERPREFIX="🌵 "

# get_time: Void -> Void
# Prints current 12 hour time
function get_time() {
	echo "%D{%r}"
}

# get_git_info: Void -> Void
# Prints current git info
function get_git_info(){
	if git rev-parse --git-dir > /dev/null 2>&1; then
			if [[ -z $(git_prompt_info 2> /dev/null) ]]; then
            	echo "$(git_prompt_status)"
        	else
            	echo "$(git_prompt_info 2> /dev/null) $(git_prompt_status)"
        	fi
	else
        echo ""
	fi
}



# get_pwd: Void -> Void
# Prints the present working directory
function get_pwd(){
	echo "%{$fg[magenta]%}$(print -rD $PWD)%{$reset_color%}"
}

# get_usr: Void -> Void
# Prints the current user to the terminal
function get_usr() {
	echo "%{$USERCOLOR%}$USER%{$reset_color%}"
}



# Sets the prompt
PROMPT='
$(get_usr) $(get_time)\
 [$(get_pwd)]
$ROOTPREFIX$USERPREFIX $PROMPT_ARROW %{$reset_color%}'

# Sets the right side of the screens prompt
RPROMPT='$(get_git_info)%{$reset_color%}'


# Sets some of the git symbols
ZSH_THEME_GIT_PROMPT_PREFIX="at %{$fg[blue]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%} ✔"

# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[red]%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[default]%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[default]%}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[magenta]%}?"

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$fg_bold[default]%}^"


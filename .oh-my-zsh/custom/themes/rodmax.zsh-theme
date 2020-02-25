local git_info='$(git_prompt_info)$(git_prompt_status)%{$reset_color%}'
# last command return code
local return_code='%(?,,%{$fg[red]%} RC=%?%{$reset_color%})'

local user_color='blue'
test $UID -eq 0 && user_color='red'

PROMPT='%{$fg[$user_color]%}[%~/] %{$reset_color%}'
RPROMPT+="${git_info}"
RPROMPT+="${return_code}"

# git status variables

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "

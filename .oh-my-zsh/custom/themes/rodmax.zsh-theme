# shellcheck disable=SC2016,SC2168,SC2034,SC2154

local git_info=''
# last command return code
local return_code='%(?,,%{$fg[red]%} RC=%?%{$reset_color%})'

local user_color='blue'
test $UID -eq 0 && user_color='red'

PROMPT='%{$fg[$user_color]%}[%~/]$(parse_git_dirty) %{$reset_color%}'
RPROMPT+="%{$fg[green]%}"
RPROMPT+='$(git_current_branch)[$(git_commits_ahead)/${git_commits_behaind}]'
RPROMPT+="%{$reset_color%}"
RPROMPT+="${return_code}"


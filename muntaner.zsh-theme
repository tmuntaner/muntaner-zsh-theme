if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

function line_separator() {

  local termwidth
  (( termwidth = ${COLUMNS} - 1 ))

  local display_line="$FG[237]"

  for i in {1..$termwidth}; do
    display_line="${display_line}-"
  done

  echo "${display_line} %{$reset_color%}"
}

function spacing() {

  local termwidth
  (( termwidth = ${COLUMNS} - ${#$(get_pwd)} - ${#$(get_date)} - ${#$(get_connection_info)} - ${#$(git_prompt_info)} ))

  local spacing=""
  for i in {1..$termwidth}; do
    spacing="${spacing} "
  done
  echo $spacing
}

function get_pwd()
{
  echo "$FG[052]%~%{$reset_color%}"
}

function get_connection_info()
{
  echo "$FG[022][%n@%m]%{$reset_color%}"
}

function get_date()
{
  echo "$FG[052]%w %t%{$reset_color%}"
}

# primary prompt
PROMPT='
$(line_separator)
$(get_connection_info) $(get_pwd) $(git_prompt_info)
$(line_separator)
$FG[001]%(!.#.»)%{$reset_color%} '

PROMPT2='%{$FG[052]%}\ %{$reset_color%}'

RPS1='${return_code}'
RPROMPT="$(get_date)"

eval my_orange='$FG[214]'

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075](branch:"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"

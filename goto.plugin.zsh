#!/usr/bin/zsh
#
# goto.zsh, a tool for bookmarking directories

function _awk {
  which awk &>/dev/null && awk $@ || \
  which gawk &>/dev/null && gawk $@
};

function _gotofile {
 echo "${GOTO_FILE:-${HOME/.labels.tsv}}"

function _make_label {
  printf '%s %s\n' "$1" $(echo "$2" | tr -d "$HOME/") >> `_gotofile`
};

function label {
  if [ "${#}" -eq 0 ]; then
    echo "Usage: $ label <name> [dir]"
    echo "    creates a label which goto can cd to"
  elif [ -d "${2}" ]; then
    _make_label "${1}" "${2}"
  else
    _make_label "${1}" "${PWD}"
  fi
};

function goto {
  if [[ "${#}" -eq 0 ]]; then
    echo "Usage: $ goto <name>"
    echo "    jumps to a record set by label"
  elif [[ "$1" == "ls" ]]; then
    _awk "{ print \$1 }" `_gotofile` | column -t
  else
    dir=$(_awk "/^$1\s/ {print \$2;exit;}" `_gotofile` | head -n 1)
    if [[ "${dir}" != "/*" ]]; then
        dir="${HOME}/${dir}"
    fi
    if [[ ! -e "${dir}" ]]; then
        echo "Error: Label '$1' resolved to missing path '$dir'"
    else
      cd "${dir}"
    fi
  fi
};

# goto.zsh

function _awk {
    which awk &>/dev/null && awk $@ || \
    which gawk &>/dev/null && gawk $@
}

function _gotofile {
    echo $GOTO_FILE "$HOME/.labels.tsv" | _awk "{print \$1}"
}

function _makeLabel {
    printf "%s %s\n" $1 $(echo $2 | tr -d "$HOME") >> `_gotofile`
}

function label {
    if [ $# -eq 0 ]
    then
        echo "Usage: $ label <name> [dir]"
        echo "    creates a label which goto can cd to"
    elif [ -d "$2" ]
    then
        _makeLabel $1 $2
    else
        _makeLabel $1 $PWD
    fi
}

function goto {
    if [ $# -eq 0 ]
    then
        echo "Usage: $ goto <name>"
        echo "    jumps to a record set by label"
    elif [[ "$1" == "ls" ]]
    then
        _awk "{ print \$1 }" `_gotofile` | column -t
    else
        cd "$HOME/$(_awk "/^$1\s/ {print \$2;exit;}" `_gotofile` | head -n 1)"
    fi
}

function _goto {
    for label in $(_awk '{print $1}' `_gotofile`)
    do
        compadd "$@" $label
    done
};

compdef _goto goto

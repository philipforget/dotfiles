#!/usr/bin/env bash

_tcomplete() {
    COMPREPLY=($(compgen -W "$(tmux ls -F '#S')" -- "${COMP_WORDS[1]}"))
}

complete -F _tcomplete t

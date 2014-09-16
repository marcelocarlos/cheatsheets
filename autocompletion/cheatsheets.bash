# COMPREPLY : array holds the completion results that gets displayed after pressing [TAB][TAB]
# COMP_WORDS : array of words that is typed on the command line
# COMP_CWORD : index for the COMP_WORDS array and using this different position words on command line can be accessed.
# compgen : -W holds the possible completions and the respective argument get chosen based on the $current_arg

function _cheatsheets_autocomplete {
    local curr_arg;

    curr_arg=${COMP_WORDS[COMP_CWORD]}

    cheatsheets=$(cheatsheets.sh -l | grep - | tail -n +3 | cut -d' ' -f4)
    if [ $COMP_CWORD = 1 ]; then
        COMPREPLY=(`compgen -W "$cheatsheets" -- $curr_arg`)
    fi
}
complete -F _cheatsheets_autocomplete cheatsheets.sh

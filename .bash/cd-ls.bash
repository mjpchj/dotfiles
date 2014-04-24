if $HAS_TERMINAL; then

    # Remember the last directory visited
    record_bash_lastdirectory() {
        pwd > ~/.bash_lastdirectory
    }

    cd() {
        command cd "$@" && record_bash_lastdirectory
    }

    # Go to home directory by default
    command cd

    # Then go to the last visited directory, if possible
    if [ -f ~/.bash_lastdirectory ]; then
        # Throw away errors about that directory not existing (any more)
        command cd "`cat ~/.bash_lastdirectory`" 2>/dev/null
    fi

    # Detect typos in the cd command
    shopt -s cdspell

    # Need some different options for ls on Mac
    if $MAC; then
        ls_opts='-G'
        # Use the same color scheme as Debian
        # http://geoff.greer.fm/lscolors/
        export LSCOLORS=ExGxFxDaCaDaDahbaDacec
    else
        ls_opts='--color=always --hide=*.pyc'
    fi

    # c = cd; ls
    c() {

        # cd to the given directory
        if [[ "$@" != "." ]]; then
            # If "." don't do anything, so that "cd -" still works
            # Don't output the path as I'm going to anyway (done by "cd -" and cdspell)
            cd "$@" >/dev/null || return
        fi

        # Output the path
        echo
        echo -en "\033[4;1m"
        echo $PWD
        echo -en "\033[0m"

        # List the directory contents
        ls -hF $ls_opts

    }

    # Various shortcuts for `ls`
    # ls, lsa   = short format
    # l,  la    = long format
    # ll, lla   = long format (deprecated)
    alias ls="ls -hF $ls_opts"
    alias lsa="ls -hFA $ls_opts"

    alias l="ls -hFl $ls_opts"
    alias la="ls -hFlA $ls_opts"

    # Old aliases
    alias ll='echo -e "\n\033[31mREMINDER: Use \`l\` instead of \`ll\`\033[0m\n"; l'
    alias lla='echo -e "\n\033[31mREMINDER: Use \`la\` instead of \`lla\`\033[0m\n"; la'

    # Unset the colours that are sometimes set (e.g. Joshua)
    export LS_COLORS=

    # u = up
    alias u='c ..'
    alias uu='c ../..'
    alias uuu='c ../../..'
    alias uuuu='c ../../../..'
    alias uuuuu='c ../../../../..'
    alias uuuuuu='c ../../../../../..'

    # b = back
    alias b='c -'

    # cw = web files directory
    if [ -n "$www_dir" ]; then
        alias cw="c $www_dir"
    fi

fi

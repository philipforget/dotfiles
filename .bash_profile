export LANG=ru_RU.UTF-8


_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}

complete -o default -F _pip_completion pip

##
# Your previous /Users/philipf/.bash_profile file was backed up as /Users/philipf/.bash_profile.macports-saved_2010-08-10_at_09:27:07
##

# MacPorts Installer addition on 2010-08-10_at_09:27:07: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2010-08-10_at_09:27:07: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH=/opt/local/share/man:$MANPATH
# Finished adapting your MANPATH environment variable for use with MacPorts.

if [ -f ~/.bash_philip ]; then
	. ~/.bash_philip
fi

export EDITOR=/usr/bin/vim

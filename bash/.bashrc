#
# bashrc settings
# Dave Pacheco (dap)
# Revision 0.3 (4/13/2011)
#

function path_append
{
	[[ -d "$1" ]] || return
	export PATH="$PATH:$1"
}

#
# MISCELLANEOUS GLOBAL ENVIRONMENT VARIABLES AND PATHS
#
export HOST=$(basename $(uname -n) .local)
export MACH=$(uname -p)

#
# Alternative sources of useful tools
#
path_append $HOME/bin
path_append $HOME/install/bin
path_append /usr/sbin
path_append /usr/xpg4/bin
path_append /usr/sfw/bin
path_append /opt/local/bin
path_append /opt/local/sbin

#
# Software packages installed into non-standard locations
#
path_append /usr/openwin/bin
path_append /usr/ccs/bin
path_append /usr/mysql/5.0/bin
path_append /usr/local/git/bin
path_append /opt/local/gcc34/bin

[[ -f $HOME/install/bin/resty ]] && source $HOME/install/bin/resty

#
# The rest of this file is only used for interactive sessions
#
[[ -n $PS1 ]] || return

#
# INTERACTIVE BEHAVIOR
#

#
# On supporting terminals, set TITLEBAR to a sequence that replaces the current
# title bar text with "<directory> (<host>)". We'll set the PS1 prompt to
# include this string so that we always update the title bar with the current
# directory.
#
case $TERM in
    rxvt*|xterm*|sun*)
        TITLEBAR='\[\033]0;\w (\h)\007\]'
        ;;
    *)
        TITLEBAR=''
        ;;
esac

#
# titlebar [args...]: set the window title bar to the specified string
#
# Updates PS1 to avoid resetting titlebar with each prompt. This is provided
# for use interactively or from other scripts.
#
function titlebar
{
	[[ -n $RAWPS1 ]] && export PS1="$RAWPS1"
	echo -n -e "\033]0;$@\007"
}

#
# RAWPS1 represents the actual text that shows up in the prompt (PS1). The
# actual value of PS1 includes TITLEBAR, which sets the window's title bar
# text. RAWPS1 exists so that we can keep the prompt text the same if we later
# change the title bar text. See the titlebar() function above.
#
_BOLD="`tput bold 2>/dev/null`"		# start printing bold text
_SGR0="`tput sgr0 2>/dev/null`"		# stop printing bold text
export RAWPS1="\u@${HOST} \[${_BOLD}\]\W\[${_SGR0}\] $ "
export PS1="${TITLEBAR}$RAWPS1"

#
# Pretend like we always have color. This sucks, but gnome-terminal doesn't
# advertise that it supports color. We could do this conditionally on $$'s
# parent being a gnome-terminal, but this is simpler for now and correct most
# of the time.
#
[[ $TERM = "xterm" ]] && export TERM=xterm-color

#
# Workaround strange background artifacts running prstat and cscope with above
# xterm-color (see opensolaris bug 7882 and 3032).
#
export PROMPT_COMMAND='echo -n -e "\033[0m"'

#
# Miscellaneous shell and command tweaks
#
shopt -s checkwinsize		# check window size after each command

export EDITOR=vim		# use 'vim' to edit
export VISUAL=vim		# use 'vim' to edit
export PAGER=less		# use 'less' to page

export LESS='-P ?f%f .?m(file %i of %m) .line %lb/%L .byte %bB?s/%s. ?e(END) '
export LESS="$LESS :?pB%pB\%..%t"
export TZ=US/Pacific		# San Francisco
export MACHINE_THAT_GOES_PING=1	# use "ping -s" by default
export CSCOPEOPTIONS="-r -p8"	# show more results per page
export DMAKE_MODE=parallel
export DMAKE_MAX_JOBS=4

alias mv='mv -i'		# conservative 'mv' by default
alias cp='cp -i'		# conservative 'cp' by default

#
# We want ls(1) to use colors, but this isn't supported everywhere and even
# where it is, the mechanism differs between systems.
#
if ls -dG / > /dev/null 2>&1; then
	# newer illumos
	alias ls="ls -lHFG"
elif ls -d --color=auto / > /dev/null 2>&1; then
	# GNU
	alias ls="ls -lHF --color=auto"
else
	# older Solaris
	alias ls="ls -lHF"
fi

if which vimfluence > /dev/null 2>&1; then
	export WIKI_EDITOR="vim +\"set ft=confluencewiki\""
	export WIKI_URL="http://hub.joyent.com/wiki"
	alias vimwiki="vimfluence dev"
fi

function ilcs
{
	(cd $HOME/work/reference/illumos-joyent/usr/src; cscope -dq)
}

#
# bashrc settings
# Dave Pacheco (dap)
#

#
# path_append DIR: appends DIR to path only if it exists
#
function path_append
{
	[[ -d "$1" ]] || return
	export PATH="$PATH:$1"
}

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
# MISCELLANEOUS GLOBAL ENVIRONMENT VARIABLES AND PATHS
#
export HOST=$(basename $(uname -n) .local)
export MACH=$(uname -p)
export PATH=

# Prefer my own versions of tools to copies installed elsewhere.
path_append $HOME/bin
path_append $HOME/install/bin

# SmartOS pkgsrc
path_append /opt/local/bin
path_append /opt/local/sbin

# OS X pkgsrc
path_append /usr/pkg/bin
path_append /usr/pkg/sbin

# System tools
path_append /bin
path_append /sbin
path_append /usr/bin
path_append /usr/sbin

# Locally installed tools
path_append /usr/local/bin
path_append /usr/local/sbin


#
# Non-interactive command customizations
#
export TZ=US/Pacific		# San Francisco
export MACHINE_THAT_GOES_PING=1	# use "ping -s" by default
export BUNYAN_NO_PAGER=1	# don't page by default

export MANTA_URL=https://us-east.manta.joyent.com
export MANTA_USER=dap
export MANTA_KEY_ID="56:f3:e1:56:3d:e6:f7:83:a9:ce:19:5d:62:ba:5c:1f"
export SDC_URL=https://us-west-1.api.joyentcloud.com
export SDC_ACCOUNT=$MANTA_USER
export SDC_KEY_ID=$MANTA_KEY_ID

#
# Interactive behavior
#
if [[ -n $PS1 ]]; then
	#
	# On supporting terminals, set TITLEBAR to a sequence that replaces the
	# current title bar text with "<directory> (<host>)". We'll set the PS1
	# prompt to include this string so that we always update the title bar
	# with the current directory.
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
	# RAWPS1 represents the actual text that shows up in the prompt (PS1).
	# The actual value of PS1 includes TITLEBAR, which sets the window's
	# title bar text. RAWPS1 exists so that we can keep the prompt text the
	# same if we later change the title bar text. See the titlebar()
	# function above.
	#
	_BOLD="`tput bold 2>/dev/null`"		# start printing bold text
	_SGR0="`tput sgr0 2>/dev/null`"		# stop printing bold text
	export RAWPS1="\u@${HOST} \[${_BOLD}\]\W\[${_SGR0}\] $ "
	export PS1="${TITLEBAR}$RAWPS1"

	#
	# Miscellaneous shell and command tweaks
	#
	shopt -s checkwinsize		# check window size after each command
	
	export EDITOR=vim		# use 'vim' to edit
	export VISUAL=vim		# use 'vim' to edit
	export PAGER=less		# use 'less' to page
	export LESS='-P ?f%f .line %lb/%L .byte %bB?s/%s. ?e(END):?pB%pB\%..%t'
	export CSCOPEOPTIONS="-r -p8"	# show more results per page

	alias mv='mv -i'		# conservative 'mv' by default
	alias cp='cp -i'		# conservative 'cp' by default
	alias mls="mls -l"

	#
	# We want ls(1) to use colors, but this isn't supported everywhere and
	# even where it is, the mechanism differs between systems.
	#
	if ls -d --color=auto / > /dev/null 2>&1; then
		# GNU
		alias ls="ls -lHF --color=auto"
	elif ls -dG / > /dev/null 2>&1; then
		# newer Solaris
		alias ls="ls -lHFG"
	else
		# older Solaris
		alias ls="ls -lHF"
	fi
fi

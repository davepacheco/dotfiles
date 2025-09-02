#
# zathras-specific interactive behavior
#
if [[ -n $PS1 ]]; then
	function ilcs
	{
		(cd $HOME/projects/illumos-joyent/usr/src; cscope -dqp8)
	}
fi

# For Mac, append the file that `pipx` puts binaries into.
# (Something else seems to put some binaries into this, too.)
path_append $HOME/.local/bin

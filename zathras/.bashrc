#
# zathras-specific interactive behavior
#
if [[ -n $PS1 ]]; then
	function ilcs
	{
		(cd $HOME/projects/illumos-joyent/usr/src; cscope -dqp8)
	}
fi

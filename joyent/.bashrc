#
# On work dev systems, add marlin and manta tools to the PATH.
#
path_append $HOME/work/tools/manta-marlin/client/sbin
path_append $HOME/work/tools/manta-marlin/node_modules/moray/bin
path_append $HOME/work/tools/node-manta/bin

# On work systems, we always use thoth user "thoth".
export THOTH_USER=thoth

# Dev tool configuration (assumes local Moray tunnel)
export MORAY_URL=tcp://127.0.0.1:2020/

#
# Configure Manta environment variables for the staging Manta instance.
#
function staging()
{
	set -o xtrace
	export MANTA_URL=https://172.26.5.11
	export MANTA_TLS_INSECURE=1
	set +o xtrace
}

#
# Interactive behavior
#
if [[ -n $PS1 ]]; then
	function ilcs
	{
		(cd $HOME/work/reference/illumos-joyent/usr/src; cscope -dqp8)
	}

	function cph
	{
		awk 'NR<3 && /us-east-'$1'/{print $2}' $HOME/Manta/p | pbcopy
	}
fi

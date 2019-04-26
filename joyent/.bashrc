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
	export MANTA_URL=https://manta.staging.joyent.us
	export PS1="[STAGING] $PS1"
	set +o xtrace
}

#
# Configure Manta environment variables for the SPC us-east instance.
#
function spceast()
{
	set -o xtrace
	export MANTA_URL=https://us-east.manta.samsungcloud.io
	export PS1="[SPC EAST] $PS1"
	set +o xtrace
}

#
# Configure Manta environment variables for the SPC eu-central instance.
#
function spccentral()
{
	set -o xtrace
	export MANTA_URL=https://eu-central.manta.samsungcloud.io
	export PS1="[CENTRAL] $PS1"
	set +o xtrace
}

#
# Configure Manta environment variables for the SPC ap-southeast instance.
#
function spcsoutheast()
{
	set -o xtrace
	export MANTA_URL=https://ap-southeast.manta.samsungcloud.io
	export PS1="[SOUTHEAST] $PS1"
	set +o xtrace
}

#
# Configure Manta environment variables for the SPC ap-northeast instance.
#
function spcnortheast()
{
	set -o xtrace
	export MANTA_URL=https://ap-northeast.manta.samsungcloud.io
	export PS1="[NORTHEAST] $PS1"
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

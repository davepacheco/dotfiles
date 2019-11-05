#
# zathras-specific interactive behavior
#
if [[ -n $PS1 ]]; then
	function ilcs
	{
		(cd $HOME/projects/illumos-joyent/usr/src; cscope -dqp8)
	}
fi

# zathras-specific Docker configuration
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.100:2376"
export DOCKER_CERT_PATH="/Users/dap/.docker/machine/machines/default"
export DOCKER_MACHINE_NAME="default"

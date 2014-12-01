#
# Local boot2docker settings
#
export DOCKER_HOST=tcp://192.168.59.103:2375

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
# rbenv bullcrap (see rbenv init -)
#
export PATH="/Users/dap/.rbenv/shims:${PATH}"
source "/usr/local/Cellar/rbenv/0.4.0/libexec/../completions/rbenv.bash"
rbenv rehash 2>/dev/null
rbenv() {
  typeset command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval `rbenv "sh-$command" "$@"`;;
  *)
    command rbenv "$command" "$@";;
  esac
}

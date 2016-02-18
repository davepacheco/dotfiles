#
# Local boot2docker settings
#
export DOCKER_CERT_PATH=/Users/dap/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
export DOCKER_HOST=tcp://192.168.59.103:2376

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

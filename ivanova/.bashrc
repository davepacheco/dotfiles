path_append /usr/gnu/bin
path_append /opt/ooce/bin
path_append /opt/ooce/sbin

# Set paths for CockroachDB, Clickhouse, and `json` tools
path_append /home/dap/tools/cockroachdb/bin
path_append /home/dap/tools/clickhouse
path_append /home/dap/.node_modules/bin

# Put temporary files into /danger_zone so they don't use physical memory and
# also don't block on synchronous writes.  This is obviously super dangerous for
# anything that needs to be crash-safe.
export TMPDIR=/dangerzone/omicron_tmp

source $HOME/.cargo/env

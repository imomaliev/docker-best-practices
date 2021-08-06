#!/usr/bin/env bash
# NOTE: if there is no bash can cause
# standard_init_linux.go:190: exec user process caused "no such file or directory"

# https://docs.docker.com/compose/startup-order/
set -euo pipefail

if [[ "$1" = 'app' ]]; then
    PATH=/app/.venv/bin:$PATH exec echo 'app'
fi

PATH=/app/.venv/bin:$PATH exec "$@"

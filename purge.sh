#!/bin/bash

set -o nounset -o pipefail -o errexit
SCRIPT_DIR=$(readlink -f "$0" | xargs dirname)

DIST=$(readlink -f "${DIST-$SCRIPT_DIR/dist}")

mapfile -t FILEs < <(cd "$DIST" && find -type f -printf '%P\n')

cd "$HOME/git/wwwo/tasks"
pipenv run wwwo-purge -- "https://rootmos.io/livesplit" "${FILEs[@]}"

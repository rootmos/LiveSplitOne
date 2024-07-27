#!/bin/bash

set -o nounset -o pipefail -o errexit
SCRIPT_DIR=$(readlink -f "$0" | xargs dirname)

DIST="$SCRIPT_DIR/dist"
rm -rf "$DIST"

(
    cd "$SCRIPT_DIR"
    npm run build:core:release && npm run publish
)

(
    cd "$HOME/git/wwwo/tasks"
    pipenv run wwwo-upload "$DIST" s3://rootmos-www/livesplit
)

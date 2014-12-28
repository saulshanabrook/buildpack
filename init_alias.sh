#!/bin/bash
set -eo pipefail

cd /tmp/code/

/tmp/runner/init $@ < /tmp/slug.tgz

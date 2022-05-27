#!/bin/bash
set -euo pipefail

echo $BUILDKITE_PULL_REQUEST_BASE_BRANCH
echo $BUILDKITE_COMMIT


git diff --stat $BUILDKITE_PULL_REQUEST_BASE_BRANCH...$BUILDKITE_COMMIT


if ! git diff --name-only $BUILDKITE_PULL_REQUEST_BASE_BRANCH...$BUILDKITE_COMMIT | grep -qvE '(.md$)'
then
    echo "Only docs were updated, not running the pr-validation pipeline."
    exit 1
else
    echo "Running pr-validation pipeline."
    exit 0
fi

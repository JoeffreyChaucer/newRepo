#!/bin/bash

set -euo pipefail

result="$(buildkite-agent step get outcome --step filter)"


if [ $result == "passed" ]; then
buildkite-agent pipeline upload <<YAML
steps:
  - label: "The pr pipeline"
    trigger: "firstproject"
    build:
      env:
        RESULT: "${result}"
YAML
fi

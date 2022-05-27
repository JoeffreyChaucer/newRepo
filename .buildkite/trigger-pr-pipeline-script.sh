#!/bin/bash

set -euo pipefail

result="$(buildkite-agent step get outcome --step filter)"

buildkite-agent pipeline upload <<YAML
steps:
  - label: "The pr pipeline"
    trigger: "firstproject"
    skip:  if [ $result != "passed" ]; then
        true
        else
        false
      fi
    build:
      env:
        RESULT: "${result}"
YAML

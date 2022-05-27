#!/bin/bash

set -euo pipefail

result="$(buildkite-agent step get outcome --step filter)"

buildkite-agent pipeline upload <<YAML
steps:
  - label: "The pr pipeline"
    trigger: "firstproject"
    skip:  if [ $(buildkite-agent step get "outcome" --step "filter") == "soft_failed" ]; then
        "skip"
      fi
    build:
      env:
        RESULT: "${result}"
YAML

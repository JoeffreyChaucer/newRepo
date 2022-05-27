#!/bin/bash

set -euo pipefail

result="$(buildkite-agent step get outcome --step filter-md-script)"

buildkite-agent pipeline upload <<YAML
steps:
  - label: "The pr pipeline"
    command: ".buildkite/pr-pipeline.yml"
    build:
      env:
        RESULT: "${result}"
YAML

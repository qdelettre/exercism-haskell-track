#!/bin/bash

for f in $(find ../.. -name stack.yaml -printf '%h\n' | sort -u); do
  pushd $f > /dev/null;
  # Install dependencies
  stack build --system-ghc --test --bench --no-run-tests --no-run-benchmarks --only-dependencies
  # Build
  stack build --system-ghc --test --bench --no-run-tests --no-run-benchmarks
  # Test
  stack test --system-ghc
  
  if ! [ $? -eq 0 ]; then
    exit 1
  fi
  popd > /dev/null;
done
#!/bin/bash

pushd web
  elm make src/main.elm
popd

python3 josh.py

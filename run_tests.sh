#!/bin/bash

sudo docker run --rm \
  -v /$(pwd)://work \
  -w //work \
  ghdl/vunit:llvm-master sh -c ' \
    VUNIT_SIMULATOR=ghdl; \
    for f in $(find ./ -name 'run.py'); do python3 $f; done \
  '

#!/bin/bash

sudo docker run -w `pwd` -v `pwd`:`pwd` --rm -it quartus24.1 -t create-quartus-project.tcl

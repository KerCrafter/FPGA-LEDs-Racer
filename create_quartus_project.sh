#!/bin/bash

sudo docker run -w `pwd` -v `pwd`:`pwd` --rm -it quartus25.1 -t create-quartus-project.tcl

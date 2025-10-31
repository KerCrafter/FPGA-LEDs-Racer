#!/bin/bash

sh create_quartus_project_verilog.sh
sudo docker run -w `pwd` -v `pwd`:`pwd` --rm -it quartus24.1 --flow compile LEDs-racer-verilog.qpf

#!/bin/bash

sh create_quartus_project.sh
sudo docker run -w `pwd` -v `pwd`:`pwd` --rm -it quartus24.1 --flow compile LEDs-racer.qpf

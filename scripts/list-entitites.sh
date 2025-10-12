#!/bin/bash

grep -E -r "entity (.+) is" --include='*.vhd' --exclude '*_tb.vhd' | sed 's/entity //' | sed 's/ is//' | sed 's/:/ => /'

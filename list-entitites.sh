#!/bin/bash

grep -E -r "entity (.+) is" --include='*.vhd' --exclude '*_tb.vhd'

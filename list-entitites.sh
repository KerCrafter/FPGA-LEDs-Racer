#!/bin/bash

grep -E -r "entity (.+) is" --exclude-dir='.git' --exclude=LICENSE --exclude='*.bak' --exclude '*_tb.vhd'

#!/bin/bash

grep -Eo 'work.([_a-zA-Z]+)' $1 | cut -d "." -f2

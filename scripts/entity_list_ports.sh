#!/bin/bash

grep -E '[a-z_]+ :\ (out|in|buffer)\ (.+)' $1

#!/bin/bash
#kill the loop running in the background

loop_pid=$(ps -ef | grep "task1_part6_loop.sh" | grep -v grep | awk '{print $2}' | tr -d '[:space:]')

kill -9 $loop_pid

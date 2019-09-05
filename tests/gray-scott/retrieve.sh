#!/bin/bash

echo "scaling, engine, writer ranks, L, start time, end tiem"
for jobdir in *_*_*_* ; do
    echo -n $jobdir | sed  's/_/,/g'
    if ls $jobdir/*.out 1> /dev/null 2>&1 ; then
        awk '/WF Start/ {printf ",%s,",$3}' $jobdir/*.out
        awk '/WF Finish/ {printf "%s",$3}' $jobdir/*.out
    fi
    echo
done

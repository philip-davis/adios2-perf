#!/bin/bash -x

for jobdir in $(find -maxdepth 1 -iname '*_*_*_*' | sort -t _ -k 3 -n) ; do
    if [ ! -f $jobdir/submitted ] ; then
        cd $jobdir
        qsub -M philip.e.davis@rutgers.edu job.sh &> submitted
        result=$?
        cd ..
    fi
    if [ ! $result -eq 0 ] ; then
        rm $jobdir/submitted
        exit
    fi
done

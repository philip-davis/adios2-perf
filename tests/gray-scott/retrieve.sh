#!/bin/bash

MACHINE={$MACHINE:-summit}

if [ "${MACHINE}" == "cori" ] ; then
    OUTEXT=out
elif [ "${MACHINE}" == "theta" ] ; then
    OUTEXT=output
fi

echo "scaling, engine, writer ranks, L, start time, end time"
for jobdir in *_*_*_* ; do
    echo -n $jobdir | sed  's/_/,/g'
    if ls $jobdir/*.${OUTEXT} 1> /dev/null 2>&1 ; then
        awk '/WF Start/ {printf ",%s,",$3}' $jobdir/*.${OUTEXT}
        awk '/WF Finish/ {printf "%s",$3}' $jobdir/*.${OUTEXT}
    fi
    echo
done

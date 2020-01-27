#!/bin/bash -x

MACHINE=${MACHINE:-summit}
SUBMIT=
if [ "${MACHINE}" == "theta" ] ; then
    SUBMIT=qsub
elif [ "${MACHINE}" == "cori" ] ; then
    SUBMIT=sbatch
elif [ "${MACHINE}" == "summit" ] ; then
    SUBMIT=bsub
else
    echo "Unknown platform: can't submit jobs"
    exit
fi

for jobdir in $(find -maxdepth 1 -iname '*_*_*_*' | sort -t _ -k 3 -n) ; do
    if [ ! -f $jobdir/submitted ] ; then
        cd $jobdir
        ${SUBMIT} job.sh &> submitted
        result=$?
        cd ..
    fi
    if [ ! $result -eq 0 ] ; then
        rm $jobdir/submitted
        exit
    fi
done

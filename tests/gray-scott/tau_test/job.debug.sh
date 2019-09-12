#!/bin/bash
#COBALT -t 30
#COBALT -n 3
#COBALT --attrs mcdram=cache:numa=quad
#COBALT -q debug-cache-quad
#COBALT -A ${ALLOCNAME}

APERF_BASE=
export PATH=$PATH:${APERF_BASE}/adiosvm/Tutorial/gray-scott/build:${APERF_BASE}/tau2/craycnl/bin
rm -rf *.bp *.sst

WPPN=64
if [ 64 -gt 128 ] ; then
    WPPN=128
fi

RPPN=64
if [ 64 -gt 4 ] ; then
    RPPN=4
fi

export TAU_CALLPATH=0    # turns on call path profiling
export TAU_CALLPATH=100   # should be deep enough
export TAU_EBS_KEEP_UNRESOLVED_ADDR=1
export TAU_PROFILE_PREFIX=writer
export TAU_PROFILE_FORMAT=merged


echo "WF Start: $(date +%s)"
aprun -p davis-test -n 128 -N $WPPN tau_exec -T mpi,pthread  gray-scott cfg.json &>write.log &
export TAU_PROFILE_PREFIX=reader
aprun -p davis-test -n 4 -N $RPPN tau_exec -T mpi,pthread  pdf_calc gs.bp pdf.bp &>read.log 100 &
wait
echo "WF Finish: $(date +%s)"

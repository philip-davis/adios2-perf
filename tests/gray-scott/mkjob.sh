#!/bin/bash

MACHINE=theta

SCALING=$1
ENGINE=$2
NWRITERS=$3

SIZE=

if [ "$SCALING" == "strong" ] ; then
    SIZE=128
elif [ "$SCALING" == "weak" ] ; then
    SIZE=128
    while [ $((SIZE * SIZE * SIZE)) -lt $((128 * 128 * NWRITERS)) ] ; do
        SIZE=$((SIZE + 32))
    done
    if [ $((SIZE * SIZE * SIZE)) -gt $((128 * 128 * NWRITERS)) ] ; then
        echo "bad nwriter!"
        exit
    fi
else exit
fi

WNODES=$((NWRITERS / 32))
NREADERS=$((NWRITERS / 32))
RNODES=$((NREADERS / 32))
while [ $((32 * RNODES)) -lt $NREADERS ] ; do
    RNODES=$((RNODES + 1))
done

NNODES=$((WNODES+RNODES))
DIR_NAME=${SCALING}_${ENGINE}_${NWRITERS}

if [ ! -d $DIR_NAME ] ; then
    mkdir $DIR_NAME
fi

if [ ${NNODES} -lt 128 ] ; then
    NNODES=128
fi

export NNODES
if [ ! -f cfg/${MACHINE}.header ] ; then
    echo "No cfg/${MACHINE}.header file"
    exit
fi
envsubst '${NNODES}' < cfg/${MACHINE}.header > $DIR_NAME/job.sh

export WNODES RNODES NWRITERS NREADERS
envsubst '$WNODES $RNODES $NWRITERS $NREADERS' < cfg/job.${ENGINE} >> $DIR_NAME/job.sh

export SIZE ENGINE
envsubst '$SIZE $ENGINE' < cfg/cfg.json > $DIR_NAME/cfg.json
cp cfg/${ENGINE}.xml $DIR_NAME/adios2.xml

#!/bin/bash

MACHINE=theta

SCALING=$1
SIZE=$2
ENGINE=$3
NWRITERS=$4

if [ "$SCALING" == "strong" ] ; then
    LEN=$SIZE
elif [ "$SCALING" == "weak" ] ; then
    LEN=128
    while [ $((LEN * LEN * LEN)) -lt $((SIZE * NWRITERS)) ] ; do
        LEN=$((LEN + 32))
    done
    if [ $((LEN * LEN * LEN)) -gt $((SIZE * NWRITERS)) ] ; then
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
DIR_NAME=${SCALING}_${ENGINE}_${NWRITERS}_${LEN}

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

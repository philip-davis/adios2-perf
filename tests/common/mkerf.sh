#1/bin/bash

NWRANKX=$1
NWRANKY=$2
NRRANKX=$3
NRRANKY=$4
XSIZE=$5
YSIZE=$6

echo "app 0: /ccs/home/pdavis/summit/ADIOS2.main/ADIOS2/build.5/bin/heatTransfer_write_adios2 heat_insitumpi.xml heat $NWRANKX $NWRANKY $XSIZE $YSIZE 20 20
app 1: /ccs/home/pdavis/summit/ADIOS2.main/ADIOS2/build.5/bin/heatTransfer_read heat_insitumpi.xml heat heat.sst.out $NRRANKX $NRRANKY

cpu_index_using: physical
overlapping_rs: warn
skip_missing_cpu: warn
skip_missing_gpu: allow
skip_missing_mem: allow
oversubscribe_cpu: error
oversubscribe_gpu: allow
oversubscribe_mem: allow
launch_distribution: packed
"

NWRANK=$((NWRANKX * NWRANKY))
NRRANK=$((NRRANKX * NRRANKY))

cpu=0
host=1
for rank in $( seq 0 1 $((NWRANK - 1)) ) ; do
    echo "rank: $rank: { host: $host; cpu: {${cpu}-$((cpu+3))} } : app 0" 
    cpu=$((cpu + 4))
    if [ "$cpu" -eq "64" ] ; then
        cpu=$((cpu + 24))
    fi
    if [ "$cpu" -eq "152" ] ; then
        cpu=0
        host=$((host + 1))
    fi
done

if [ "$cpu" -ne "0" ] ; then 
    host=$((host + 1))
    cpu=0
fi

for rank in $( seq $NWRANK 1 $((NRRANK + NWRANK - 1)) ) ; do
    echo "rank: $rank: { host: $host; cpu: {${cpu}-$((cpu+3))} } : app 1"
    cpu=$((cpu + 4))
    if [ "$cpu" -eq "64" ] ; then
        cpu=$((cpu + 24))
    fi
    if [ "$cpu" -eq "152" ] ; then
        cpu=0
        host=$((host + 1))
    fi
done

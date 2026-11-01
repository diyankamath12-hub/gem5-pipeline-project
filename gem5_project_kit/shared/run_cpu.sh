#!/bin/bash
# usage: bash run_cpu.sh <result_name> <CPU> <program> 
#   CPU = TimingSimpleCPU (simple, no pipeline)  or  MipsO3CPU (pipelined)
# optional env vars: GEM5_OPTS (before the script), SE_OPTS (after the script)
# example: SE_OPTS="--l1d_size=8kB" bash run_cpu.sh o3small_loop MipsO3CPU loop
KIT="$(cd "$(dirname "$0")/.." && pwd)"
NAME=$1; CPU=$2; PROG=$3
mkdir -p "$KIT/results"
cd /workspaces/gem5
build/MIPS/gem5.opt -d "$KIT/results/$NAME" $GEM5_OPTS configs/deprecated/example/se.py --cpu-type=$CPU --caches $SE_OPTS -c "$KIT/bin/$PROG" > "$KIT/results/$NAME.log" 2>&1
if grep -q "Exiting @ tick" "$KIT/results/$NAME.log"; then
  echo "OK     $NAME  $(grep -E '^simInsts|system.cpu.numCycles' "$KIT/results/$NAME/stats.txt" | awk '{print $1"="$2}' | tr '\n' ' ')"
else
  echo "FAILED $NAME  (see results/$NAME.log, send last 15 lines to Diya)"
fi

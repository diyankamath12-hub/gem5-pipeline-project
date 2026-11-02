#!/bin/bash
cd /workspaces/gem5
BIN=$(dirname "$(find /workspaces -type f -name arraysum -path '*bin*' | head -1)")
echo "Program: control_hazard (random branch the CPU cannot predict)"
read -p "Press Enter to run it with the pipeline trace on..."
build/MIPS/gem5.opt -d /tmp/d_ctl --debug-flags=O3PipeView --debug-start=10000000 --debug-end=10100000 --debug-file=trace.txt configs/deprecated/example/se.py --cpu-type=MipsO3CPU --caches -c $BIN/control_hazard > /dev/null 2>&1
echo "Branch mispredictions:"
grep "branchMispredicts" /tmp/d_ctl/stats.txt | head -2
echo "One flushed instruction (issue, complete and retire are all 0):"
grep -m1 -B6 "retire:0:" /tmp/d_ctl/trace.txt

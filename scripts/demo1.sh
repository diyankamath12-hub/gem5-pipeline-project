#!/bin/bash
cd /workspaces/gem5
BIN=$(dirname "$(find /workspaces -type f -name arraysum -path '*bin*' | head -1)")
echo "Program: arraysum (sums 10,000 numbers). Same program, same cache."
read -p "Press Enter to run the SIMPLE CPU..."
build/MIPS/gem5.opt -d /tmp/d_simple configs/deprecated/example/se.py --cpu-type=TimingSimpleCPU --caches -c $BIN/arraysum > /dev/null 2>&1
S=$(grep "system.cpu.numCycles" /tmp/d_simple/stats.txt | awk '{print $2}')
echo "Simple CPU cycles: $S"
read -p "Press Enter to run the PIPELINED CPU..."
build/MIPS/gem5.opt -d /tmp/d_pipe configs/deprecated/example/se.py --cpu-type=MipsO3CPU --caches -c $BIN/arraysum > /dev/null 2>&1
P=$(grep "system.cpu.numCycles" /tmp/d_pipe/stats.txt | awk '{print $2}')
echo "Pipelined CPU cycles: $P"
python3 -c "print('Speedup:', round($S/$P, 2), 'x')"

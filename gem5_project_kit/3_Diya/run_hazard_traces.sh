#!/bin/bash
# Hazard programs on the pipelined CPU with the pipeline trace switched on
D="$(cd "$(dirname "$0")/../shared" && pwd)"
export GEM5_OPTS="--debug-flags=O3PipeView --debug-start=10000000 --debug-end=10100000 --debug-file=trace.txt"
for p in data_hazard control_hazard structural_hazard; do
  bash $D/run_cpu.sh o3_$p MipsO3CPU $p
done

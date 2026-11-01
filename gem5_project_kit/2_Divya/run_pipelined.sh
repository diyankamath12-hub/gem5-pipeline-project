#!/bin/bash
# Pipelined CPU (MipsO3CPU) runs, normal cache and small cache = the "after" numbers
D="$(cd "$(dirname "$0")/../shared" && pwd)"
for p in loop arraysum factorial; do
  bash $D/run_cpu.sh o3_$p MipsO3CPU $p
  SE_OPTS="--l1d_size=8kB" bash $D/run_cpu.sh o3small_$p MipsO3CPU $p
done

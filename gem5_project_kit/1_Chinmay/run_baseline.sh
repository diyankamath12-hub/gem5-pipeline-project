#!/bin/bash
# Simple CPU (no pipeline) runs = the "before" numbers
D="$(cd "$(dirname "$0")/../shared" && pwd)"
for p in loop arraysum factorial; do
  bash $D/run_cpu.sh base_$p TimingSimpleCPU $p
done

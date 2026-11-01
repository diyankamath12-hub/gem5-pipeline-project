#!/usr/bin/env python3
"""Reads every stats.txt under a folder and writes results_summary.csv.
usage: python3 collect_stats.py /workspaces/gem5-pipeline-project/results"""
import os, sys, csv
root = sys.argv[1] if len(sys.argv) > 1 else "."
keys = ["simInsts", "system.cpu.numCycles", "system.cpu.cpi",
        "system.cpu.commit.branchMispredicts", "system.cpu.iew.lsqFullEvents"]
rows = []
for d, _, files in os.walk(root):
    if "stats.txt" in files:
        vals = {}
        for line in open(os.path.join(d, "stats.txt"), errors="ignore"):
            parts = line.split()
            if len(parts) >= 2 and parts[0] in keys and parts[0] not in vals:
                vals[parts[0]] = parts[1]
        rows.append([os.path.relpath(d, root)] + [vals.get(k, "") for k in keys])
rows.sort()
with open("results_summary.csv", "w", newline="") as f:
    w = csv.writer(f); w.writerow(["run"] + keys); w.writerows(rows)
for r in rows: print(r)
print("saved results_summary.csv")

# Diya - Hazard analysis

**Status: the analysis is DONE and already pushed.** `HAZARD_ANALYSIS.md` is the finished write-up.
This folder lets you re-run everything if needed.

Programs (in `shared/programs`):
- data_hazard.c: every line uses the result of the line before it
- control_hazard.c: unpredictable branch (pseudo-random), so the predictor guesses wrong about half the time
- structural_hazard.c: many loads and stores in a row

## Steps (only if you rerun)
1. Do **Step 0** from the main README (a Codespace with gem5 built, patched, programs compiled).
2. Run the 3 hazard programs with the pipeline trace on:
```
cd /workspaces/gem5_project_kit/3_Diya
bash run_hazard_traces.sh
```
3. Evidence commands:
```
cd /workspaces/gem5_project_kit/results
head -14 o3_data_hazard/trace.txt                      # forwarding example
grep -c "retire:0:" o3_control_hazard/trace.txt        # flushed instructions
grep -m1 -B6 "retire:0:" o3_control_hazard/trace.txt   # one flushed instruction
grep -E "branchMispredicts" o3_control_hazard/stats.txt
grep -E "lsqFullEvents|no_targets" o3_structural_hazard/stats.txt
```
4. Push: `cd /workspaces/gem5_project_kit/shared` then `bash push_results.sh diya`.
5. Stop the Codespace.

Numbers from the earlier run (yours may differ slightly): see the table in HAZARD_ANALYSIS.md.

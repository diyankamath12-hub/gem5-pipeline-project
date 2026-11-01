# Chinmay - Simple CPU runs (the "before" numbers)

**Goal:** run the 3 test programs (loop, arraysum, factorial) on the simple CPU, which has no pipeline.
Everyone compares against these numbers.

Programs (already in `shared/programs`):
- loop.c: adds the numbers 1 to 1,000,000
- arraysum.c: fills an array of 10,000 numbers and sums it 50 times
- factorial.c: factorial of 10, repeated 100,000 times

## Steps
1. Do **Step 0** from the main README (Codespace, build gem5, patch, compile). Wait until the build is done.
2. Run the 3 simple-CPU runs:
```
cd /workspaces/gem5_project_kit/1_Chinmay
bash run_baseline.sh
```
   You should see 3 lines starting with `OK` and showing `simInsts` and `numCycles`.
   If you see `FAILED`, send the last 15 lines of `results/<name>.log` to Diya.
3. Write the numbers in this table (and send a screenshot of the 3 OK lines to the group):

| Program | Instructions (simInsts) | Cycles (numCycles) |
|---|---|---|
| loop | | |
| arraysum | | |
| factorial | | |

4. Push the results to the repo:
```
cd /workspaces/gem5_project_kit/shared
bash push_results.sh chinmay
```
   If GitHub asks to log in, it should already be signed in inside the Codespace. If the push fails, send the error to Diya.
5. Stop the Codespace.

**You hand over:** the table and the pushed `results/chinmay` folder.

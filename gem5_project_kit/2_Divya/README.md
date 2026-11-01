# Divya - Pipelined CPU runs (the "after" numbers) and cache experiment

**Goal:** run the same 3 programs on the pipelined CPU (`MipsO3CPU`), and again with a smaller data cache,
to show (1) how much faster the pipeline is and (2) how cache size changes speed.

## Steps
1. Do **Step 0** from the main README (Codespace, build gem5, patch, compile). Wait until the build is done.
2. Run the 6 pipelined runs (3 programs x normal cache and small cache):
```
cd /workspaces/gem5_project_kit/2_Divya
bash run_pipelined.sh
```
   You should see 6 lines starting with `OK`.
   - `o3_` = pipelined CPU, normal cache
   - `o3small_` = pipelined CPU, 8 kB data cache
   If the `o3small_` lines say `FAILED`, the option name `--l1d_size` may differ in this version.
   Send the last 15 lines of `results/o3small_loop.log` to Diya.
3. Fill in this table (send a screenshot of the 6 OK lines to the group):

| Program | Pipelined cycles | Pipelined, small cache cycles |
|---|---|---|
| loop | | |
| arraysum | | |
| factorial | | |

   Disha will put Chinmay's simple-CPU cycles next to these and work out the speedup.
4. Write about one page for the report:
   - What was compared (simple CPU vs pipelined CPU, normal vs small cache).
   - The table.
   - Which program benefited most from the pipeline.
   - Which program slowed down most with the small cache. Expect `arraysum`, because it uses lots of memory.
     `loop` and `factorial` use almost no memory, so they may barely change. That is normal.
   - Say the pipelined CPU is `MipsO3CPU` with stages Fetch, Decode, Rename, Issue/Execute/Writeback, Commit,
     and that `MipsMinorCPU` was tried but gave wrong results in this gem5 version.
5. Push the results:
```
cd /workspaces/gem5_project_kit/shared
bash push_results.sh divya
```
6. Stop the Codespace.

**You hand over:** the table, the one-page write-up, and the pushed `results/divya` folder.

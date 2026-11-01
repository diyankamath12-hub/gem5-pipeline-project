# Project 9: Pipelined MIPS in gem5 - Team Kit

Everyone builds gem5 in their OWN GitHub Codespace (a free cloud computer in the browser).
Our VMs run out of memory, the Codespace has 16 GB, so the build works there.

## Who does what
| Person | Folder | Job | Needs from others |
|---|---|---|---|
| Chinmay | 1_Chinmay | Simple CPU (no pipeline) runs = "before" numbers | nothing |
| Divya | 2_Divya | Pipelined CPU runs + small cache experiment = "after" numbers | nothing |
| Diya | 3_Diya | Hazard analysis (data, control, structural) | nothing (already done) |
| Disha | 4_Disha | Report: collects all numbers, table, graph, text | everyone's results |

Nobody waits for anybody except Disha, who needs the others' results at the end.

## Step 0 - EVERYONE (Chinmay, Divya, Diya if rerunning, Disha only if she wants to run things)
1. Accept the GitHub invite to `diyankamath12-hub/gem5-pipeline-project`.
2. Open the repo on github.com -> green **Code** button -> **Codespaces** tab -> three dots -> **New with options** -> pick **4-core** -> Create.
3. Drag `gem5_project_kit.zip` into the file panel (left side) of the Codespace.
4. In the terminal at the bottom:
```
cd /workspaces
unzip gem5_project_kit.zip
cd gem5_project_kit/shared
bash setup_gem5.sh
```
   - If it asks about pre-commit hooks, type `y` and press Enter.
   - Takes 1.5 to 3 hours. KEEP THE BROWSER TAB OPEN (click in the terminal every 20 min). Codespaces stops itself after about 30 min idle.
   - If it stops, reopen the Codespace at github.com/codespaces, then run the same two lines again:
     `cd /workspaces/gem5_project_kit/shared` and `bash setup_gem5.sh`. It continues where it stopped.
5. After the build finishes:
```
cd /workspaces/gem5_project_kit/shared
bash patch_objectlist.sh
bash compile_programs.sh
```
   `patch_objectlist.sh` must print `found` (or `already patched`). `compile_programs.sh` must print `compiled` 7 times.

## Step 1 - your own folder
Open the README.md inside your folder (1_Chinmay, 2_Divya, 3_Diya or 4_Disha) and follow it.

## If something fails
Send a screenshot of the last 15 lines to Diya in the group.

## When you are done
Stop the Codespace: github.com/codespaces -> three dots -> **Stop codespace**.
(Running Codespaces use your free hours.)

## Known notes about this gem5 version
- The pipelined CPU used is `MipsO3CPU` (stages: Fetch, Decode, Rename, Issue/Execute/Writeback, Commit).
  `MipsMinorCPU` gave wrong results in this version (stops after 4 instructions), so it is not used.
- Programs are "bare" (no C library, no printf), so they only need the exit system call.
- `se.py` lives in `configs/deprecated/example/` in this version.
- The `--l1d_size=8kB` option has not been tested. If the `o3small_` runs say FAILED, send the log to Diya.

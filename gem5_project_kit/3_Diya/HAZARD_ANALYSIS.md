# Hazard Analysis

## Setup
We ran three small MIPS programs on gem5 using `MipsO3CPU`, a pipelined CPU. Its stages are Fetch, Decode, Rename, Issue/Execute/Writeback and Commit. We tried the simpler `MipsMinorCPU` first, but it stopped after 4 instructions in this gem5 version, so we used `MipsO3CPU`. We recorded a pipeline trace (O3PipeView) and read the counters in `stats.txt`.

Because this CPU can finish more than one instruction per cycle, a CPI below 1 is normal.

| Program | Instructions | Cycles | CPI |
|---|---|---|---|
| data_hazard | 600,011 | 400,505 | 0.667 |
| control_hazard | 2,150,116 | 2,025,285 | 0.844 |
| structural_hazard | 1,239,856 | 1,036,754 | 0.720 |

## 1. Data hazard
**What it is:** An instruction needs a result that an earlier instruction has not produced yet. If it ran too early, it would use a wrong value.

**Our program:** `data_hazard.c` runs a loop where each line uses the result of the line before it (`a = a + b; c = a + d; e = c + a; b = e + c`).

**What the trace shows:** The instruction `addiu r5, r3, 4` completes at tick 9997500. The next instruction, `addu r2, r3, r5`, needs `r5`. It issues at tick 9997500, the same moment its input is ready, and completes at tick 9998000, one cycle (500 ticks) later.

**How the pipeline handled it:** Forwarding. The result is passed straight to the waiting instruction instead of waiting for it to be written back. The CPI of 0.667 shows the dependencies did not slow the pipeline much.

## 2. Control hazard
**What it is:** A branch decides which instruction comes next. The pipeline has to guess, and a wrong guess means the instructions already started must be thrown away.

**Our program:** `control_hazard.c` makes a pseudo-random number in every loop and branches on one bit of it. The branch is unpredictable on purpose. Our first version used `i % 3`, but the predictor learned that pattern, so we replaced it.

**What the trace and stats show:**
- `branchMispredicts` is 50,147 out of 100,000 loop iterations, about half.
- The trace has 282 flushed instructions in the recorded window. A flushed instruction, for example the `nop` at `0x004001bc`, was fetched, decoded, renamed and dispatched, but its `issue`, `complete` and `retire` are all 0. It never executed.
- This program has the highest CPI of the three (0.844), because wrong guesses waste work.

**How the pipeline handled it:** It guesses the branch direction (branch prediction). When the guess is wrong, it flushes the wrong instructions and restarts from the correct one.

## 3. Structural hazard
**What it is:** Two instructions need the same piece of hardware at the same time, so one has to wait.

**Our program:** `structural_hazard.c` repeats `arr[i] = arr[i-1] + arr[i+1]` over a 10,000-element array, so there are many loads and stores in a row.

**What the stats show:**
- `lsqFullEvents` is 722. The load/store queue became full 722 times and stalled the pipeline.
- `dcache.blockedCycles::no_targets` is 45. The data cache was blocked for 45 cycles.
- The functional units themselves were never busy (`statFuBusy` is 0), because this CPU has plenty of them. The bottleneck was the memory queue.

**How the pipeline handled it:** It stalled. New memory instructions waited until space in the queue was free.

## Conclusion
All three hazards appeared in the simulation, and the pipeline dealt with each in its own way: forwarding for data hazards, prediction and flushing for control hazards, and stalling for structural hazards. Control hazards cost the most in our tests, with the highest CPI.

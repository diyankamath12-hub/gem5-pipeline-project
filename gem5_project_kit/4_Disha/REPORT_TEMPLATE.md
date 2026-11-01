# Report: Simulating a Pipelined MIPS Processor in gem5

## 1. Introduction
- The project simulates a pipelined MIPS processor in gem5 and compares it with a simple, non-pipelined CPU.
- Aim: show how much pipelining speeds up programs, and what slows it down (hazards).

## 2. Pipeline theory
- A simple CPU finishes one instruction before starting the next. A pipelined CPU splits work into stages so several instructions are in progress at once, like an assembly line.
- Classic 5 stages: fetch, decode, execute, memory, write-back.
- Hazards: data (needs a result not ready yet), control (a branch changes what comes next), structural (two instructions need the same hardware).
- Fixes: forwarding (pass a result early), stalling (wait), branch prediction and flushing (guess, and throw away wrong work).

## 3. Setup
- gem5 built for the MIPS target, run in GitHub Codespaces (Ubuntu).
- Programs compiled with a MIPS cross-compiler (static, no C library).
- Simple CPU: `TimingSimpleCPU`. Pipelined CPU: `MipsO3CPU` (Fetch, Decode, Rename, Issue/Execute/Writeback, Commit). `MipsMinorCPU` gave wrong results in this gem5 version, so it was not used.
- Programs: loop (adds 1 to 1,000,000), arraysum (sums a 10,000-element array 50 times), factorial (factorial of 10, repeated 100,000 times).

## 4. Results: simple CPU vs pipelined CPU
(main table, speedup column, bar graph, 3 to 4 lines: how much faster and why)

## 5. Cache experiment
(Divya's table and write-up: normal cache vs 8 kB data cache)

## 6. Hazard analysis
(paste Diya's HAZARD_ANALYSIS.md)

## 7. Conclusion
- Pipelining speeds up programs by overlapping instructions.
- Hazards cause stalls and flushes that reduce the gain; branch-heavy code cost the most.
- Cache size also changes performance, especially for memory-heavy programs.

# Simulating a Pipelined MIPS Processor in gem5

DLCD lab project. We compare a simple (non-pipelined) MIPS CPU with a pipelined
MIPS CPU in the gem5 simulator, and show what slows a pipeline down (hazards).

**Team**

| Member | Part |
|---|---|
| Chinmay P N | Simple CPU baseline |
| Divya Dosetty | Pipelined CPU and cache experiment |
| Diya Nekkarkad Kamath | Hazard analysis (data, control, structural) |
| Disha S | Results and report |

The full report is in `DLCD Project.pdf`.

## What we did

- **Architecture:** MIPS (32-bit, little-endian). gem5 is built for MIPS (`build/MIPS/gem5.opt`) and run in syscall-emulation mode.
- **Simple CPU:** `TimingSimpleCPU` finishes one instruction before starting the next.
- **Pipelined CPU:** `MipsO3CPU` (stages: Fetch, Decode, Rename, Issue/Execute/Writeback, Commit). It is also out-of-order and can finish more than one instruction per cycle, so part of the speedup is not from pipelining alone.
- **Programs:** `loop` (sums 1 to 1,000,000), `arraysum` (sums a 10,000-element array 50 times), `factorial` (10! repeated 100,000 times), plus one small program per hazard.
- `MipsMinorCPU` was tried first but stopped after 4 instructions in this gem5 version, so it was not used.

## Results

Simple vs pipelined (cycles, with caches):

| Program | Simple CPU | Pipelined | Speedup | Pipelined, 8 kB data cache |
|---|---|---|---|---|
| loop | 14,000,560 | 2,000,593 | 7.00x | 2,000,593 |
| arraysum | 5,168,492 | 1,037,671 | 4.98x | 1,859,727 |
| factorial | 15,600,552 | 2,100,778 | 7.43x | 2,100,778 |

Only `arraysum` is affected by the smaller cache, because it is the only memory-heavy program.

Hazards (pipelined CPU, instructions exclude nops):

| Program | Instructions | Cycles | CPI | Evidence |
|---|---|---|---|---|
| data_hazard | 600,011 | 400,505 | 0.667 | forwarding in the pipeline trace |
| control_hazard | 2,150,116 | 2,025,285 | 0.942 | 50,147 branch mispredicts |
| structural_hazard | 1,239,856 | 1,036,754 | 0.836 | load/store queue full 722 times |

CPI = cycles divided by instructions. gem5's own `cpi` stat also counts nops, so it shows 0.844 and 0.720 for the control and structural programs. The values above use real instructions only.

## Repository layout

| Path | What it holds |
|---|---|
| `gem5_project_kit/` | The project kit: setup and run scripts (`shared/`), one folder per team member, compiled MIPS binaries (`bin/`) and results |
| `programs/` | C sources for `loop`, `arraysum` and `factorial` |
| `bare/` | Final bare-metal hazard programs and `start.S` |
| `hazards/` | Earlier versions of the hazard programs (kept for history; `bare/` has the final ones) |
| `results/` | gem5 output (`stats.txt`, configs) for each run, per person and per hazard |
| `scripts/` | `demo1.sh` (simple vs pipelined) and `demo2.sh` (control hazard trace) |
| `DLCD Project.pdf` | The project report |
| `gem5_project_kit.zip` | Zipped copy of the kit |

## How to run

1. Set up gem5 for MIPS in a Codespace (build, cache patch and compiling the programs). See `gem5_project_kit/README.md`.
2. Run the live demos from the repo folder:

```bash
./scripts/demo1.sh   # simple CPU vs pipelined CPU on arraysum, prints the speedup
./scripts/demo2.sh   # control hazard: mispredict count and one flushed instruction
```

3. To rerun the full experiments, use the scripts in `gem5_project_kit/`:

```bash
bash 1_Chinmay/run_baseline.sh        # simple CPU baseline
bash 2_Divya/run_pipelined.sh         # pipelined CPU, normal and 8 kB cache
bash 3_Diya/run_hazard_traces.sh      # hazard programs with the pipeline trace
```

## How to check that the project is MIPS

```bash
file gem5_project_kit/bin/control_hazard         # ELF 32-bit LSB executable, MIPS, MIPS32 rel2
ls /workspaces/gem5/build/                       # contains MIPS
grep -i mips results/o3_control_hazard/config.ini    # MipsISA, MipsDecoder, MipsMMU, ...
mipsel-linux-gnu-objdump -d gem5_project_kit/bin/loop | grep -A12 "<main>"   # MIPS instructions, nop in the branch delay slot
```

## Notes

- The programs are bare-metal: a tiny `start.S` replaces the normal C startup, because gem5 does not support some system calls the normal startup needs on MIPS. The programs print nothing.
- The simple CPU counts the `nop` placed after each branch (branch delay slot); the pipelined model does not. Speedups therefore compare cycles, not instruction counts.
- The first control-hazard test used `i % 3`, but the branch predictor learned that pattern. The final version branches on a pseudo-random bit, which causes about 50,000 mispredictions.

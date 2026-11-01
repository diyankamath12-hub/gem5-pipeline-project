#!/bin/bash
# Compiles every .c in shared/programs into ../bin (MIPS, static, no C library needed).
KIT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$KIT/bin"
cd "$KIT/shared/programs"
for f in *.c; do
  p="${f%.c}"
  OPT=-O1
  if [ "$p" = "control_hazard" ]; then OPT=-O0; fi   # keep a real branch
  mipsel-linux-gnu-gcc -static -nostdlib -nostartfiles -fno-pic -mno-abicalls -G0 $OPT -e __start start.S "$f" -o "$KIT/bin/$p" && echo "compiled $p" || echo "FAILED $p"
done
ls "$KIT/bin"

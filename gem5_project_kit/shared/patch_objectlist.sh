#!/bin/bash
# One-line fix so --caches works for MIPS. Python file only, no rebuild. Run ONCE after the build.
python3 - << 'PY'
p = "/workspaces/gem5/configs/common/ObjectList.py"
s = open(p).read()
if "return ISA.MIPS" in s:
    print("already patched")
else:
    old = '        else:\n            raise ValueError("Unable to determine CPU ISA.")'
    new = ('        elif hasattr(m5.objects, "MipsCPU") and issubclass(\n'
           '            cls, m5.objects.MipsCPU\n        ):\n            return ISA.MIPS\n') + old
    print("found" if old in s else "NOT FOUND - send a screenshot of this to Diya")
    open(p, "w").write(s.replace(old, new))
PY

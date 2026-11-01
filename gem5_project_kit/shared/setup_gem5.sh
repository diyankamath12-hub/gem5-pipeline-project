#!/bin/bash
# Installs tools, downloads gem5, builds it for MIPS. Run ONCE in your Codespace.
# Takes 1.5 to 3 hours. If the Codespace stops, open it again and run this script again:
# it continues where it stopped.
set -e
sudo apt update
sudo apt install -y build-essential git m4 scons zlib1g-dev libprotobuf-dev protobuf-compiler libgoogle-perftools-dev python3-dev python3-pip gcc-mipsel-linux-gnu
cd /workspaces
if [ ! -d gem5 ]; then git clone https://github.com/gem5/gem5; fi
cd gem5
echo "If it asks about pre-commit hooks, type y and press Enter."
scons build/MIPS/gem5.opt -j4
ls -lh build/MIPS/gem5.opt
echo "BUILD DONE. Next: bash patch_objectlist.sh"

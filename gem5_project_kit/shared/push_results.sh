#!/bin/bash
# usage: bash push_results.sh <yourname>      e.g. bash push_results.sh divya
KIT="$(cd "$(dirname "$0")/.." && pwd)"
REPO=/workspaces/gem5-pipeline-project
mkdir -p "$REPO/results/$1"
cp -r "$KIT"/results/* "$REPO/results/$1/"
cd "$REPO"
git pull --rebase
git add .
git commit -m "results from $1"
git push

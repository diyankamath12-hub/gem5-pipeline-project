# Disha - Report (collect numbers, table, graph, text)

**Goal:** turn everyone's results into the final report. You do NOT have to build gem5 or run anything.

## Start now (no results needed)
1. Open `REPORT_TEMPLATE.md` in this folder and copy it into Word or Google Docs.
2. Write the Introduction, Pipeline theory and Setup sections (the template has the text points).
3. Paste Diya's finished hazard write-up (`3_Diya/HAZARD_ANALYSIS.md`) into section 6.

## When Chinmay and Divya have pushed their results
1. Get the numbers. Easiest: in a Codespace or any computer with the repo cloned:
```
cd gem5-pipeline-project
git pull
python3 /path/to/gem5_project_kit/shared/collect_stats.py results
```
   This prints every run and saves `results_summary.csv` (instructions, cycles, CPI, mispredicts).
   You can open the CSV in Excel or Google Sheets.
   Or open each `stats.txt` and search for `simInsts` and `numCycles`.
2. Fill the main table:

| Program | Simple CPU cycles (base_) | Pipelined cycles (o3_) | Speedup | Pipelined, small cache (o3small_) |
|---|---|---|---|---|
| loop | | | | |
| arraysum | | | | |
| factorial | | | | |

   Speedup = simple cycles divided by pipelined cycles. Example: 1,200,000 / 400,000 = 3 times faster.
3. Make a bar graph in Excel or Google Sheets: 3 programs on the x-axis, two bars each (simple vs pipelined cycles).
4. Add Divya's one-page cache write-up and the cache table.
5. Write the Conclusion, export to PDF, post in the group.

**You hand over:** the main table, the graph, and the final report.

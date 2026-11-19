# OpenSees bridge models

Tcl input files for the ten bridge case studies in the paper. **Run with OpenSees 2.5.0 (rev 6248)**, the version used for every analysis in the paper.

## Files

Each folder is named with the bridge label used in the paper. The `.tcl` file keeps its original name from the analyses.

| Folder | File | Bridge | Spans | Column at bent 1 / bent 2 / bent 3 | Columns |
|---|---|---|---|---|---|
| `RB1/`  | `B1.tcl`  | RB1  | 3 | 6.71 m (22 ft) / 6.71 m (22 ft) / — | As-built |
| `RB1R/` | `B1R.tcl` | RB1R | 3 | 6.71 m (22 ft) / 6.71 m (22 ft) / — | TiAB retrofit |
| `RB2/`  | `B5.tcl`  | RB2  | 4 | median / median / median | As-built |
| `RB2R/` | `B5R.tcl` | RB2R | 4 | median / median / median | TiAB retrofit |
| `IB1/`  | `B2.tcl`  | IB1  | 4 | short / median / long | As-built |
| `IB1R/` | `B2R.tcl` | IB1R | 4 | short / median / long | TiAB retrofit |
| `IB2/`  | `B3.tcl`  | IB2  | 4 | short / long / median | As-built |
| `IB2R/` | `B3R.tcl` | IB2R | 4 | short / long / median | TiAB retrofit |
| `IB3/`  | `B4.tcl`  | IB3  | 4 | median / short / long | As-built |
| `IB3R/` | `B4R.tcl` | IB3R | 4 | median / short / long | TiAB retrofit |

Clear column heights: short = 3.05 m (10 ft), median = 4.88 m (16 ft), long = 6.71 m (22 ft). Bridge geometry and reinforcement are shown in Fig. 4 of the paper, and the modeling approach is described in the "Bridge Case Studies — Bridge Models" section.

## Units

kip, inch, second (g = 386.4 in/s²). Ground motion acceleration input files (`../ground_motions/`) are in units of g.

## What each file does

1. Builds the 3D model (`model basic -ndm 3 -ndf 6`): fiber-section columns with the lap-splice bond-slip material (and, in the retrofitted models, the TiAB truss elements modeled with `Pinching4`), elastic superstructure and cap beams, and `HyperbolicGapMaterial` abutment springs.
2. Applies gravity loads (load-controlled static analysis).
3. Runs a bidirectional uniform-excitation transient analysis (Newmark, γ = 0.5, β = 0.25; Δt = 0.005 s) with an adaptive algorithm/time-step loop for convergence, and writes nodal displacements, drifts, accelerations, reactions, and column forces/deformations to `.out` files in the working directory.

## Running one record at a given intensity

Lines 12–16 of each file hold placeholder values that were replaced for each record and intensity level before each run:

```tcl
set Qake_X "X_Eake.g3";          # acceleration file applied along GMdirectionX
set Qake_Y "Y_Eake.g3";          # acceleration file applied along GMdirectionY
set Qake_factor "$g*100000";     # replace 100000 with the scale factor SF
set npts 100000;                 # replace with the number of points in the record
set dt 100000;                   # replace with the record time step (s)
```

1. **Record files:** copy `X_Eake.g3` and `Y_Eake.g3` of the record from [`../ground_motions/`](../ground_motions/) into the folder you run from (acceleration in g, constant time step).
2. **`npts` and `dt`:** take them from [`../ground_motions/index.csv`](../ground_motions/index.csv).
3. **Scale factor:** for intensity level Sa(T₁) = *S*, use SF = *S* / Sa(T₁) of the **long-duration** record of that pair, for that bridge and orientation, as listed in [`../ground_motions/Sa_T1_by_bridge.csv`](../ground_motions/Sa_T1_by_bridge.csv). The same SF is applied to the short-duration record of the pair ("same scale factor" approach). Intensity levels were run in steps of 0.1g.
4. **Orientation:** `pattern UniformExcitation` applies `X_Eake.g3` along global direction `GMdirectionX` and `Y_Eake.g3` along `GMdirectionY`. The files as published use `GMdirectionX 2` / `GMdirectionY 1` (orientation 2). Each pair was also run in orientation 1 (`GMdirectionX 1` / `GMdirectionY 2`); swapping these two values is the only change to the model file.

Then run:

```
OpenSees B1.tcl
```

The record pairs, the rotation angles and scale factors applied to the short-duration records, and the record characteristics are listed in Tables S1–S5 in this repository.

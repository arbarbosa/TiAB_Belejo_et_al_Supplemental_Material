# OpenSees bridge models

Tcl input files for the ten bridge case studies in the paper. **Run with OpenSees 2.5.0** (the version used for every analysis in the paper).

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

kip, inch, second (g = 386.4 in/s²). Ground motion acceleration input files are in units of g.

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

- Put the two horizontal components of the record in `X_Eake.g3` and `Y_Eake.g3` (one acceleration value in g per line, or whitespace-separated, at constant time step `dt`) in the folder you run from.
- **Scale factor:** for intensity level Sa(T₁) = *S*, use SF = *S* / Sa(T₁) of the **long-duration** record of the pair. The same SF is applied to the short-duration record of that pair ("same scale factor" approach). Intensity levels were run in steps of 0.1g.
- **Record orientation:** the files apply component 2 along global X (`GMdirectionX 2`) and component 1 along global Y (`GMdirectionY 1`). Each record pair was also run in the other orientation, obtained by swapping these two values (`GMdirectionX 1`, `GMdirectionY 2`); this is the only difference between the two orientations.

Then run:

```
OpenSees B1.tcl
```

The record pairs, the rotation angles and scale factors applied to the short-duration records, and the record characteristics are listed in Tables S1–S5 in this repository.

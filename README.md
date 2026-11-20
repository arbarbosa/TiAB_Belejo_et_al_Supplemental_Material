# Supplemental Material — BEENG-8526

Supplemental material for the manuscript:

> Belejo, A., Barbosa, A. R., and Higgins, C. "Seismic Fragility of Regular and Irregular RC Bridges with Lap-Splice Deficiencies: Influence of Retrofits with Titanium Bars and Ground Motion Duration." Submitted to *ASCE Journal of Bridge Engineering* (manuscript BEENG-8526).

A permanent DOI will be assigned to this material if the paper is accepted for publication.

## Repository contents

```
.
├── README.md                                            this file
├── LICENSE                                              CC BY 4.0
├── Belejo_et_al_Supplemental_Material_TablesS1-S5.pdf   Tables S1–S5 (PDF)
├── Belejo_et_al_Supplemental_Material_TablesS1-S5.docx  Tables S1–S5 (Word)
├── models/                                              OpenSees (Tcl) models of the ten bridges
│   ├── README.md                                        model details and how to run them
│   ├── RB1/   B1.tcl      RB1R/ B1R.tcl
│   ├── RB2/   B5.tcl      RB2R/ B5R.tcl
│   ├── IB1/   B2.tcl      IB1R/ B2R.tcl
│   ├── IB2/   B3.tcl      IB2R/ B3R.tcl
│   └── IB3/   B4.tcl      IB3R/ B4R.tcl
└── ground_motions/                                      ground motion input files used in the analyses
    ├── README.md                                        file format, sources, and notes
    ├── index.csv                                        source records, npts and dt for each input file
    ├── Sa_T1_by_bridge.csv                              Sa(T1) used for scaling, by bridge, orientation and pair
    ├── long_duration/pair01 … pair32/                   X_Eake.g3, Y_Eake.g3
    ├── short_duration_3span_RB1/pair01 … pair32/        X_Eake.g3, Y_Eake.g3
    └── short_duration_4span_RB2_IB/pair01 … pair32/     X_Eake.g3, Y_Eake.g3
```

| Item | Description |
|---|---|
| Tables S1–S5 | Ground motion records used in the incremental dynamic analyses: record pairs for the three-span bridges (Table S1) and four-span bridges (Table S2), with the scale factors and rotation angles applied to the short-duration records, and the characteristics of the long-duration records (Table S3) and the two sets of short-duration records (Tables S4 and S5). |
| `models/` | One Tcl input file per bridge case study (as-built and TiAB-retrofitted). Folder names are the bridge labels used in the paper; file names are the original names used in the analyses. See [`models/README.md`](models/README.md). |
| `ground_motions/` | The acceleration input files used in the analyses (32 long-duration records and two sets of 32 short-duration records), with the number of points, time step, and Sa(T₁) values used to scale them for each bridge. See [`ground_motions/README.md`](ground_motions/README.md). |

## Software required to reproduce the results

**OpenSees version 2.5.0 (rev 6248)**: Tcl interpreter, Windows 64-bit executable `OpenSees2.5.exe`. All analyses in the paper were run with this version. Other OpenSees versions may give slightly different results because of changes to material models, element formulations, and solvers between releases.

The models use only built-in OpenSees 2.5.0 commands, including `Concrete02`, `ConcretewBeta`, `Steel02`, `Pinching4`, `HyperbolicGapMaterial`, `Elastic`, `dispBeamColumn` with `Fiber` sections, `elasticBeamColumn`, `truss`, and `zeroLength` elements.

## License

[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Please cite the paper above if you use this material.

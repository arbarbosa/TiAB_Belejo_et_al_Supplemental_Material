# Ground motion input files

The acceleration input files used in the analyses, exactly as read by the OpenSees models in [`../models/`](../models/).

## Folders

| Folder | Records | Used for |
|---|---|---|
| `long_duration/pair01` … `pair32` | 32 long-duration records (2011 Tohoku, 2010 Maule and 1985 Valparaíso Chile, 1999 Chi-Chi, 1999 Kocaeli, 2002 Denali, 1992 Landers, 2004 Niigata) | All ten bridges |
| `short_duration_3span_RB1/pair01` … `pair32` | 32 short-duration records | RB1, RB1R (Tables S1 and S4) |
| `short_duration_4span_RB2_IB/pair01` … `pair32` | 32 short-duration records | RB2, RB2R, IB1–IB3, IB1R–IB3R (Tables S2 and S5) |

Pair numbers are the pair numbers in Tables S1 and S2. Each `pairNN` folder holds:

- `X_Eake.g3`: horizontal component applied along global direction `GMdirectionX` in the model
- `Y_Eake.g3`: horizontal component applied along global direction `GMdirectionY`

One acceleration value (in g) per line, at constant time step. The long-duration files are the as-recorded components. The short-duration files are the processed records used in the analyses: each is a linear combination of the two as-recorded components of the source record (i.e., already rotated and amplitude-adjusted during record preparation). The intensity scale factor is **not** included in any file; it is applied in the model through `Qake_factor` (see [`../models/README.md`](../models/README.md)).

## Tables

- **`index.csv`**: one row per record: set, pair, folder, source record files (PEER `.AT2` format), number of points `npts`, and time step `dt_s` (s). Use `npts` and `dt` in the model header.
- **`Sa_T1_by_bridge.csv`**: the Sa(T₁) values (g) of the long- and short-duration records used to compute the scale factors, for each bridge, orientation (`GMdirectionX`/`GMdirectionY` values), and pair. The scale factor at intensity *S* is SF = *S* / `Sa_T1_long_g`, applied to both records of the pair.

## Sources and credit

The records were obtained from:

- the PEER NGA-West2 database (records with `RSN` file names), Pacific Earthquake Engineering Research Center, https://ngawest2.berkeley.edu
- K-NET/KiK-net, National Research Institute for Earth Science and Disaster Resilience (NIED), Japan (2011 Tohoku records, `KR_` file names), https://www.kyoshin.bosai.go.jp
- strong-motion networks of Chile for the 2010 Maule and 1985 Valparaíso records

Please credit these sources if you use the records, and follow their terms of use.

## Notes

- **Pair 10, long duration:** the analyses used station MYGH08 (Iwanuma) NS for `X_Eake.g3` and station MYGH09 (Shiroishi) EW for `Y_Eake.g3`. The files here are the ones used in the analyses.
- **Pair 28, four-span short-duration set:** the record files of pair 26 (2007 Chuetsu-oki, Joetsu Kita, RSN4840) were used, with the rotation and scale factor of pair 28 (see the footnotes to Tables S2 and S5).

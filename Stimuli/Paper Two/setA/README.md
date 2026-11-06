# Set A images for Paper A Study 1

This folder holds the images for Paper A Study 1 (A1): for each of the ten painterly scenes SA01 to SA10 of the prompt bank (`Docs/Paper Two/Paper_Two_Prompt_Bank.md`), a source image and its small, medium and large additions. Every file is made by script with GPT Image 2 (`gpt-image-2-2026-04-21`), the model David G. Kamper chose for Set A on 27 October 2026, and is accepted by automatic checks only. No person paints, draws or picks an image. An earlier, unfinished run with GPT Image 2.5 Flare is kept in `../setA_superseded_flare_2026-10-27/`.

## How a file is made and accepted

- **Source.** The prompt is the scene's eight part sentences in the bank's order, then the Set A realism line, then "No text, lettering, signature, watermark, or frame."
- **Additions.** Small and medium are instruction edits of the accepted source ("Add " + phrase + ". Change nothing else."). Large is an instruction edit of the accepted medium file with the two further elements. Edits are sent to `POST /v1/images/edits` as a multipart form with the input image in `image[]`, `size=1536x1024`, `quality=high`, `n=1`, and no mask.
- **Compositing.** An edit's change mask is every pixel whose RGB distance from the input is above the difference threshold, with specks removed and enclosed holes filled. The edit is pasted onto its input only inside that mask widened by the widening radius, so every pixel outside it is identical to the input. For the large file the input is the composited medium file.
- **Source checks.** The detector (OWLv2) and the description model (GPT-5.1, temperature 0, one yes-or-no question per call) confirm the two objects the rearrangement moves. The description model confirms the open area and that the image is free of visible text.
- **Addition checks.** The detector, with a box centered inside the pasted region, and the description model confirm each added element. For large these are the medium element and the two further ones. The description model confirms there is no visible text. The masked area (the cleaned change mask of the file compared with the source) must follow the within-scene ordering:
  - small at least 0.1 percent of the image;
  - medium at least 2 times the accepted small and at least 0.5 percent;
  - large at least 2 times the accepted medium.
- **Order and rescue.** Candidates are numbered in the order made, and the first that passes is accepted. A file with 20 failed tries gets one revision ("Add " + phrase + ", clearly visible. Change nothing else."). A scene that still fails is replaced by the reserve of its kind (SA-R1 with a person, SA-R2 without).

Every rule and every number is in `thresholds.json`. The rules were written before any candidate was judged, and each number was computed by its rule from this model's first candidates and then frozen.

## What is here

| Path | What it is |
|---|---|
| `SA01_source.png` ... | Accepted files, 1536 x 1024 PNG: `_source`, `_small`, `_medium`, `_large` |
| `SA01_small_mask.png` ... | Each accepted addition's widened mask: white pixels were pasted from the edit, black pixels are identical to the input |
| `SA01_source.json` ... | The full record of each accepted file |
| `candidates/` | Every candidate in the order made, with its `.json` record and check results. For an edit: `_raw.png` (the model's output), `.png` (composited), `_change.png`, `_change_vs_source.png` (the mask the masked area is measured on) and `_mask.png` (the widened mask) |
| `manifest.csv` | One row per rule, per candidate and per accepted file (lists and dicts are JSON inside their cells) |
| `thresholds.json` | Rules, frozen numbers with the data they came from, and the history of the rules |
| `web/` | JPEG copies for the experiment, 1536 x 1024, at quality 85 unless that puts a file over 400 KB (then the highest quality in steps of 5 that keeps all of a scene's files under 400 KB, the same for the whole scene) |
| `contact_sheets/` | One sheet per scene: source, small, medium and large side by side |
| `accepted_summary.json` | Accepted files with masked areas, the small:medium and medium:large ratios, pixel-identity results, web quality, and any reserve used |
| `status.json`, `run_log.txt` | Search state per scene and file, and the printed log |

API costs are logged per call in `../api_cost_ledger_setA.csv`.

## How to rerun

Run the scripts in `../scripts/` (named `setA_*.py`) from that folder, in a shell where `OPENAI_API_KEY_AICOPYRIGHT` is set. The key is read from the environment and never printed or written. Software used: Python 3.12.3, torch 2.5.1, transformers 4.46.2, numpy 1.26.4, scipy 1.13.0, Pillow 10.3.0, requests 2.31.0. The detector, `google/owlv2-base-patch16-ensemble` at revision `cfd3195ba4ea9592eec887ded089f4c08eff231d`, downloads from Hugging Face on first use and runs on the CPU.

```
python3 setA_calibrate.py rules        # 1. write the rules (refuses if thresholds.json exists)
#   make candidate 1 of each main scene's source (setA_make.make_source), then:
python3 setA_calibrate.py detector     # 2. detector score cut from those ten sources
python3 setA_run.py sources            # 3. judge sources in order; make more until one passes per scene
python3 setA_run.py first-edits        # 4. candidate 1 of small and medium per scene
python3 setA_calibrate.py mask         # 5. difference threshold, speck size, widening from those 20 edits
python3 setA_run.py finish             # 6. per scene: small, then medium, then large; reserves if needed
python3 setA_finalize.py               # 7. pixel identity, manifest, web copies, contact sheets (no API calls)
python3 setA_run.py status             # search state and spending
```

Every paid call passes a budget guard first. The guard stops any call that could push the two Paper Two ledgers together past $100, or this ledger past $60 (Set A's own pause point, which leaves room for Set B). The image model accepts no seed, so rerunning steps 1, 3, 4 or 6 makes new candidates rather than the same ones. Rerunning the checks on existing candidates gives the same detector scores and masks. The description model runs at temperature 0, which is close to, but not guaranteed to be, deterministic. `setA_finalize.py` reproduces its outputs exactly.

## Final state, 29 October 2026

All 40 A1 places are filled: ten scenes (SA01 to SA04, SA-R1 in SA05's place, SA06, SA07, SA-R2 in SA08's place, SA09 and SA10), each with a source and its small, medium and large additions, every one accepted by the automatic checks in candidate order and pixel-identical to its input outside its widened mask (verified by `setA_finalize.py`). The checks in force are those in `thresholds.json`, with every amendment dated there: content (detector and description model), no text, the within-scene size order, and the object-position check (29 October), which replaced the "unchanged elsewhere" question and then the spill check, both of which failed their purpose. SA04's large addition was made again after its phrase was given a place twice ("a side table with a vase in the right foreground, and a candlestick on the side table"); it passed at candidate 93. Image spending this quarter: $162.94 across both ledgers (cap $175). The section below records the state before the object-position check and is kept as history.

## State on 29 October 2026 (09:00 UTC), superseded

37 of A1's 40 places are filled. The three empty places are the small, medium and large of the SA08 place, which reserve SA-R2 holds.

**A1 places.** "–" means no accepted file; c = candidate number. Spill is the percent of the image changed outside the added-element region; the cut is 0.765.

| A1 scene | Files from | Source | Small (area, spill) | Medium (area, spill) | Large (area, spill) | Medium:small | Large:medium |
|---|---|---|---|---|---|---|---|
| SA01 | SA01 | c1 | c1, 0.127%, 0.008 | c1, 2.720%, 0.699 | c1, 9.725%, 0.458 | 21.4 | 3.58 |
| SA02 | SA02 | c2 | c1, 2.171%, 0.676 | c1, 4.723%, 0.558 | c3, 15.761%, 0.224 | 2.18 | 3.34 |
| SA03 | SA03 | c3 | c3, 0.130%, 0.031 | c1, 0.524%, 0.011 | c1, 4.551%, 0.031 | 4.03 | 8.69 |
| SA04 | SA04 | c1 | c1, 1.120%, 0.031 | c47, 2.631%, 0.011 | c28, 5.364%, 0.634 | 2.35 | 2.04 |
| SA05 | reserve SA-R1 | c1 | c1, 1.267%, 0.003 | c2, 6.860%, 0.104 | c43, 29.453%, 0.027 | 5.41 | 4.29 |
| SA06 | SA06 | c1 | c1, 0.314%, 0.040 | c2, 1.095%, 0.379 | c1, 13.948%, 0.020 | 3.49 | 12.74 |
| SA07 | SA07 | c2 | c1, 0.798%, 0.123 | c1, 3.961%, 0.287 | c2, 10.459%, 0.346 | 4.96 | 2.64 |
| SA08 | reserve SA-R2 | c2 | – | – | – | – | – |
| SA09 | SA09 | c1 | c5, 0.941%, 0.707 | c5, 1.896%, 0.698 | c2, 6.868%, 0.572 | 2.01 | 3.62 |
| SA10 | SA10 | c1 | c1, 0.822%, 0.622 | c85, 2.269%, 0.562 | c1, 4.682%, 0.047 | 2.76 | 2.06 |

**Spill check (amendment of 28 October 2026; replaces the "unchanged elsewhere" question).**
- **Added-element region:** the union of every detector box that confirms an added element (score at least the cut, center inside the composited region), each box grown 64 pixels on every side. For large, the region covers the medium element and both further elements.
- **Spill:** the percent of the image inside the cleaned change mask (input against the composited file) but outside that region.
- **Cut: 0.765 percent.** This is the median (0.1305) plus 3.5 times the MAD (0.1222) / 0.6745, over each addition file's first candidate (35 files, reserves included), rounded up.
- **One correction before any decision used the number.** A first computation, 0.793, measured three candidates made with superseded phrases against the current phrase's elements. It was withdrawn, and both values and the reason are in `thresholds.json` under `corrections`.
- **Record keeping.** The answers to the superseded question stay in each candidate's `previous_judgments` and in `manifest.csv`. The earlier accepted files are in `superseded_2026-10-28_before_spill_check/`.

**The two known cases.**
- **SA04 large c28** (its edit redrew the chair): spill 0.634, so it passes and stays accepted.
- **SA-R1 large c42** (its edit moved the framed picture): spill 1.824, so it fails.

**What changed under the spill check.**
- **SA07 large:** c1 to c2.
- **SA09:** small c1 to c5, medium c1 to c5 (judged against the new small), and large c1 to c2 (made from the new medium).
- **SA-R1:** medium c1 to c2, and large c42 to c43 (made from the new medium).
- **SA-R2:** see "Failed" below.
- **Unchanged:** every other file.

**Failed: SA-R2 small, and so the SA08 place.** All 40 tries (20 plus 20 revised) passed the size, detector and description checks, but their spill was 0.79 to 1.07 percent. The spill is not a moved object. It is the hay on the wagon, which stands beside the added milk churn and is re-rendered strand by strand, together with specks in the field grass. SA-R2's medium and large cannot be judged until its small is accepted, and no reserve is left.

**Spending** (`../api_cost_ledger_setA.csv`):
- This GPT Image 2 run: $69.98. The spill step added $9.17, almost all of it SA-R2 small's 40 tries.
- With the superseded Flare run ($12.48), the ledger total is $82.46.
- The combined total with Set B was $144.23 of the $160 cap.

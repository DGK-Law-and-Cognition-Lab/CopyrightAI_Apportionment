# CopyrightAI_Apportionment: Paper A, Study 1 (A1)

Do people divide an image built on another image into the person's part and the rest, as the U.S. Copyright Office's registration practice assumes? Alex made each first image either with an AI image generator or by painting it himself, then added something by hand or kept it as it was. Participants rate the creativity of the whole second image and of Alex's addition, say what the Office should do with his application, first without and then with the Office's rule, and how much of the image is his own work.

The study runs on Pavlovia for the UCLA Psychology subject pool (SONA) in UCLA's Fall 2026
quarter, under IRB #24-001292. Its preregistration is in `Docs/Paper Two/_source/Prereg_A1.md`
(with a Word copy in `Docs/Paper Two/Preregistrations/`). Participant data are not here yet; they
are added after collection.

## What is here

| Folder | What it holds |
|---|---|
| `Docs/Paper Two/` | The preregistration, the prompt bank (every prompt, edit phrase and rule used to make the images), the change specification that records every screen text (`_internal_notes/`), and the script that makes the Word copy |
| `Docs/IRB/`, `Analysis/R Analysis Pipeline/Study 1/qualtrics/` | The IRB-approved consent and debriefing forms and Paper One's Study 1 survey file, which the page-text check compares the pages with |
| `Stimuli/Paper Two/Pavlovia/A1/` | The study's web pages as they run on Pavlovia: `index.html`, `config.js` (every text, item and list), the stimuli and the README that documents every data column |
| `Stimuli/Paper Two/Pavlovia/engine/` | The page code shared by the lab's Paper Two studies |
| `Stimuli/Paper Two/Pavlovia/tools/` | Checks: page text against the preregistration, automatic test sessions, the formula checks, session length, the daily list update |
| `Stimuli/Paper Two/setA/` | The image set: every accepted image, `manifest.csv` (every candidate with its instruction, model, settings, checks and SHA-256), `thresholds.json` and the earlier accepted sets |
| `Stimuli/Paper Two/scripts/` | The scripts that made and checked the images |
| `Analysis/Paper Two/Power/` | The sample-size simulation and its results |

Rejected candidate images are not in this repository (they are large); they are archived on
Zenodo, and the SHA-256 checksums in `manifest.csv` verify every file.

## How to run it from a fresh copy

Needs Python 3.10 or later, Node.js, Google Chrome, and for the simulation R 4.3 or later with
lme4 and lmerTest.

1. See the study as a participant would, with every answer filled in automatically:
   `cd "Stimuli/Paper Two/Pavlovia/A1" && python3 -m http.server 8000`, then open
   `http://localhost:8000/index.html?test=1&code=12345`. Leave out `test=1&code=12345` to
   answer yourself.
2. Check that every text on the pages matches the preregistration:
   `python3 "Stimuli/Paper Two/Pavlovia/tools/check_strings.py" --study A1`. It should end with "0 fail". About 46
   strings are listed as new: the page code's own buttons and messages, which come from the lab's
   page template in another project and so have no source here.
3. Run complete automatic sessions and check every formula and data column:
   `python3 "Stimuli/Paper Two/Pavlovia/tools/run_headless_tests.py" --study A1 --out sessions_A1`, then
   `python3 "Stimuli/Paper Two/Pavlovia/tools/test_formulas_A1.py" --csv-dir sessions_A1`.
4. Rerun the sample-size simulation: `Rscript "Analysis/Paper Two/Power/sim_A1.R"`
   (about 10 to 20 minutes on 11 cores; `--quick` for a short check).
5. Remake the images (needs an API key for the image model, in an environment variable; see
   the scripts' headers): the scripts in `Stimuli/Paper Two/scripts/`. Image models do not
   return the same image twice, so a rerun makes new candidates; `manifest.csv` records the
   ones used.

## Licence

Code (.R, .py, .js, .sh) under the MIT licence; everything else under CC BY 4.0. See `LICENSE`
and `LICENSE-CC-BY-4.0.md`.

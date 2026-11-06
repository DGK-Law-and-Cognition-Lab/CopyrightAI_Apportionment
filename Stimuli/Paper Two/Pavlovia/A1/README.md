# Paper A, Study 1 (A1): Pavlovia experiment

Plain-JavaScript Pavlovia experiment for A1 ("Which part is his? Dividing credit for an image built on another source"), built on the shared engine in `../engine/` (version 1.4.0; versions 1.1.0 to 1.4.0 added the options A1 needs, and B1 runs unchanged on them). No build step and no libraries. Every participant-facing study string comes from the preregistration, `Docs/Paper Two/_source/Prereg_A1.md` (version of 1 November 2026), whose page text follows the change specification `Docs/Paper Two/_internal_notes/A1_page_revision_2026-11-01.md` (David's walk-through of 1 November 2026; in its section 13, the follow-up section; in section 14, a written reason on every trial; in section 15, the five pages of each trial, "AI image generator" throughout, and the two end scales, all of the same day); each scene's added elements come from `Docs/Paper Two/Paper_Two_Prompt_Bank.md` (the current Set A rows, with the dated phrase amendments and the reserves SA-R1 and SA-R2).

Pavlovia project: `copyright-apportionment/study-1` (preset in `.pavlovia_project`). SONA: third week of November 2026, UCLA's Fall 2026 quarter (end date 11 December 2026).

## Before launch

1. **Images.** `stimuli/` holds the 40 accepted files of `Stimuli/Paper Two/setA/web/` (1536 × 1024 JPEG, 281 to 395 KB): for each of SA01, SA06, SA02, SA07, SA03, SA-R2, SA04, SA09, SA-R1, SA10, the `_source`, `_small`, `_medium` and `_large` files. SA-R1 takes SA05's place and SA-R2 takes SA08's place (design record 12.19); the SA05 and SA08 files in `setA/web/` are not used. Installed on 29 October 2026 by `../tools/install_images.sh A1`, which compares each copy byte for byte with its source. If any Set A file is remade, run that script again; the deploy script refuses to push if any image differs from `setA/web/`.
2. **SONA credit link.** In `config.js`, set `SONA_CREDIT_URL_BASE` to the A1 listing's credit-granting URL, ending in `survey_code=`. While it is empty, a SONA participant ends on the completion page (code `ARTA1`) and is not credited automatically.
3. **Pavlovia project.** Create the project `copyright-apportionment/study-1` on Pavlovia. Then, from this folder, run `./deploy_to_pavlovia.sh`. It reads the project path from `.pavlovia_project`, clones `https://gitlab.pavlovia.org/copyright-apportionment/study-1.git`, checks that the clone points there, checks the engine copies and the 40 images, copies the page files, shows what changes, and pushes only after you type `study-1`. It never pushes `config.json` (Pavlovia serves its own) and never touches `data/`. On the dashboard, set the project to RUNNING, covered by the UCLA license, with results saved as CSV.
4. **Pilot run on Pavlovia.** `https://run.pavlovia.org/copyright-apportionment/study-1/index.html?participant=PILOT_DK1` (no SONA, no credit; flagged `is_test`). A file `data/PA_A1_PILOT_DK1_SESSION_<date>.csv` should appear in the repository. An automatic run: `...index.html?test=1&code=12345`.
5. **SONA study URL.** `https://run.pavlovia.org/copyright-apportionment/study-1/index.html?participant=%SURVEY_CODE%`. SONA fills in each participant's numeric survey code; a numeric id is treated as a SONA session, so the credit link is used at the end. Never add `row`, `code` or `test` to the SONA link.
6. **Earlier participants.** Put the SONA codes of everyone who took part in Paper One, B1 or another Paper A or Paper B study, or Prompt Position in `../tools/prior_codes.txt` (one per line, or comma separated). B1 runs in the same quarter, so its codes must be there. The daily script excludes them. The SONA prescreen restrictions remain the main safeguard.

## Daily during data collection

`../tools/daily_update.sh A1` clones the project, runs `../tools/update_open_rows.py --study A1` on its `data/` folder, rewrites `open_rows.json` so that lists with 14 analyzable participants close (target 140), and pushes only `open_rows.json` after you type `study-1`. It prints counts only (per list, per exclusion, recruited against the cap of 174). If the cap is reached or every list is full, it says to close the SONA listing.

**Internal pilot.** When 40 participants are analyzable, the script says to pause the SONA listing and prints the four registered gates, computed on every complete pilot session whatever its exclusion status: story belief "Yes" or "Partly" at least 70 percent; story recall correct at least 80 percent; "Yes" to the first rule-recall item at least 70 percent; median session at most 45 minutes. The timing gate is a median of at most 45 minutes, the posted length. If only the timing gate fails, set `DROP_ITEMS` in `config.js` to `['would_block']` (it removes the "would" item from the follow-up section), redeploy and reopen the listing; the pilot participants stay. If another gate fails, revise the materials it names (the story and reminder lines for belief and story recall; the rule paragraph for rule recall), put the pilot participants' codes in a file and pass it as `--dropped-pilot-codes FILE` to every later run (they are excluded and do not count against the cap), record the deviation, redeploy and reopen.

**After the end date** (11 December 2026), run `python3 ../tools/update_open_rows.py --study A1 --data <data folder> --target 12` so lists below the fallback of 12 per list (120 in all) stay open into the Winter 2027 quarter, until they reach 12, recruitment reaches 174, or that quarter ends.

## Files

| File | Purpose |
| --- | --- |
| `index.html` | Page shell. Loads `config.js`, then `engine.js`. |
| `config.js` | Everything specific to A1: strings, scenes and their added elements, slots, the list rule, the per-participant formulas, item lists, debriefing, values to set before launch. |
| `engine.js`, `style.css`, `captcha.png` | Copies of `../engine/` (run `../tools/sync_engine.sh A1` after changing the engine; the deploy script checks they match). |
| `open_rows.json` | The open lists, rewritten daily by `../tools/update_open_rows.py`. Starts with all 10 open. |
| `stimuli/` | 40 images, `<scene>_<source, small, medium or large>.jpg`, copied from `Stimuli/Paper Two/setA/web/`. |
| `deploy_to_pavlovia.sh` | Pushes this folder to `copyright-apportionment/study-1` only. Not itself uploaded. |
| `.pavlovia_project` | The project path, read by the deploy and daily scripts. Not uploaded. |

## Session

Device check (a phone or tablet is stopped before consent), full screen, consent (the IRB-approved survey consent form, as in B1; a participant who declines saves nothing and a SONA participant is sent to the credit link), captcha trap (Z ends the session, saved and credited), primer, three true-or-false comprehension items (one retry after the primer is shown again; a second failure ends the session, saved and credited, before the story), the story, block 1 (eight trials in random order, with the instructed-response item after the third), the follow-up section, the rule (at least 5 seconds) and its two recall items on the next page, block 2 (two trials in random order), story recall, story belief, purpose probe, ownership, experience, the Short GAAIS-10, the anthropocentric creativity beliefs, the copyright quiz, demographics, final questions, debriefing, save, SONA credit link. The session takes about 33 minutes and is posted as 45. The primer, story, each trial's story page, statements, registration decision, rule and its reminder, the introductory page and debriefing show one sentence per line (each sentence is its own string in `config.js`; the engine never splits text).

Each trial has five pages, nothing else:

1. **Story page** (at least 3 seconds): how Alex made the first image, two sentences in the same form under both stories, the key words in bold ("Alex made the next image **with an AI image generator**. / He wrote prompts, and the generator made the image from them." or "Alex **painted the next image himself**. / He used his digital painting tools and did not use any AI.").
2. **First image alone**, labeled "First image" (`preScreen`; Next is disabled for 5 seconds after it loads).
3. **Change page**: a centered title naming the first image's story ("First image: made by Alex **with an AI image generator**" or "First image: **painted by Alex himself, without using any AI**"), the statement below it, one sentence per line, with the added elements in bold, and the two images side by side below that, large, labeled "First image" and "Second image" (Next disabled for 10 seconds after both images load).
4. **Question page** (no minimum time; `questionLayout: 'side'`): the title and the two images, one above the other, in a column that stays in view, sized to the window so that both images fit beside the Next row; beside them the statement in a light box and the items: the two creativity items in the participant's order (only the whole-image item on no-change trials; the addition item names the trial's added elements), each with Paper One's definition below its question; on block-2 trials the rule reminder in a box ("**Remember the rule.**" and the rule page's two sentences that state the rule, one per line); the registration decision (three lines; options in the participant's order) with its follow-up shown only after the divided option; confidence; authorship share (sliders with no handle until clicked); and on change trials the jury item. On a window narrower than 900 pixels the column sits above the questions.
5. **Written reason**, laid out the same way: the participant's decision quoted ("You chose: “....”" and, after the divided option, "Left out: “....”") and the reason box; pasting and dropping text are blocked and attempts counted.

Every answer is required.

The follow-up section comes after the last block-1 trial and before the rule: an introductory page, then slots 6 and 7 (block 1, large addition, one under each story) again in the order first seen, each on two pages with the same top, both pages of one trial before the next trial's. The first page has the line "This time, the question is what the Office would actually do, not what it should do.", then the "would" item (same option order) with its follow-up after the divided option, and confidence; with the timing-gate remedy it is skipped. The second page has the stop-others stem and each scenario followed by its own question "Should Alex be able to stop them?" (1 to 7); item 4 (the prompts typed into an AI image generator) only on the AI page (slot 7). The answers are saved on the row of the trial they concern. The section sits after every block-1 decision because block-1 trial order is random, so an item asked on one trial could otherwise precede another trial's decision; it sits before the rule so that the "would" item records what people believe current practice is.

Story recall shows the first image of slot 0 or slot 1 again, without its title, below the line "One more question about an image you saw earlier."

## How the registered formulas are implemented

All in `config.js`; `../tools/test_formulas_A1.py` rebuilds them from the registration and the bank independently.

| Registered rule | Implementation |
| --- | --- |
| List from the SONA code modulo the number of open lists, open lists in ascending order | `engine.js` `assignRow()`: reads `open_rows.json`, sorts and de-duplicates, takes `open[code % n_open]`. If the file cannot be read, every list counts as open (`open_rows_source = fallback_all`); if it lists none, all 10 are used. A non-numeric id (pilots) gets a random open list. `?row=K` forces list K (testing). |
| Interleaved order SA01, SA06, SA02, SA07, SA03, SA-R2, SA04, SA09, SA-R1, SA10; list k puts the scene at position (j + k) mod 10 in slot j | `buildRow(k)`. |
| Slots 0 to 7 block 1: (0, 1) no change, (2, 3) small, (4, 5) medium, (6, 7) large; AI slots 0, 2, 5, 7; hand-made 1, 3, 4, 6. Slot 8 AI and slot 9 hand-made, large, block 2 | `SLOTS` in `config.js`; files `<scene>_source.jpg` and `<scene>_<amount>.jpg` (the source again on no-change trials). |
| Statements, one sentence per line: "Alex then made a second version himself, with his digital painting tools and without using any AI." / "He added **[elements]**." / "He changed nothing else."; the large amount names the medium element and then the two further ones; no change: "Alex then looked at the image again and decided to keep it as it was." | `statementFor(scene, amount)` returns the lines; depends on scene and amount only, never on the story. The addition creativity item names the same elements (`trialContent(t).vars`). |
| Option order floor(code / 10) mod 3: whole, part, refuse; part, refuse, whole; refuse, whole, part | `derive()`; the same order on the "would" item. Random when the code is not numeric (recorded in `option_order_source`). |
| Creativity-item order floor(code / 30) mod 2: 0 whole image first, 1 addition first | `derive()` gives `item_order`; `trialQuestionsFor()` orders the two items. |
| Story-recall trial floor(code / 60) mod 2: slot 0 (AI, no change) or slot 1 (hand-made, no change) | `derive()` gives `recall_position`; the recall page shows that trial's first image alone, without its title, below its introductory line. "I don't remember" counts as wrong. |
| Written reason on every trial, on its own page after the question page, below the quoted decision | `derive()` gives `reason_positions` 0 to 9 (not saved; `has_reason` is true on every row); the engine's written-reason page with `reasonQuote`. |
| Follow-up section on slots 6 and 7: the "would" item, then the stop-others items, item 4 on slot 7 only | `derive()` gives `follow_up_positions`; `buildRow()` sets `has_follow_up`. The section is a `revisit` spec with two `pages` in block 2's `before` list (`FOLLOW_UP` in `config.js`), after the last block-1 trial and before the rule, in the order first seen. The "would" line, item and confidence carry `dropGroup: 'would_block'`. |
| Creativity definition once; addition creativity item and jury item on change trials only; rule reminder above the decision in block 2 only | `trialQuestionsFor()`; `trial_items` records the items asked on each trial's question page (the definition and the reminder, which have no answer, are not listed). |
| Trial order random within each block, block 1 first; follow-up section, rule and recall items between the blocks | Engine `blocks` option: Fisher-Yates shuffle within each block; `trial_order` records the list positions in the order shown. |
| Instructed-response item after the third trial of block 1 | After the third trial's three pages. Only "Somewhat disagree" passes. |
| Purpose probe: first four options random, "Something else" last | Randomized in the page; `purpose_order` records it. |
| Exclusions computed in the page | `excl_comprehension`, `excl_captcha`, `excl_instructed`, `excl_recall`, `excl_any_in_page`. Speed (less than one third of the median), earlier participation and later sessions by the same code are applied by `../tools/update_open_rows.py`. Rule recall and story belief never exclude. |

## URL parameters

| Parameter | Effect |
| --- | --- |
| `participant`, `survey_code`, `id` | Participant id (SONA sends `participant=%SURVEY_CODE%`). An id beginning PILOT or TEST is flagged `is_test`. |
| `code` | The numeric code used by the formulas, if different from the id (testing). With `test=1` and no id, the id becomes `TEST_<code>`. |
| `platform` | `sona` or anything else; if absent, a numeric id means SONA. |
| `row` | Forces list 0 to 9 (testing only). |
| `test=1` | Test mode: every page is answered automatically, minimum times shrink to 20 ms, data are flagged `is_test` and `test_mode`, a SONA redirect is never followed, and the CSV is placed in the page (`<pre id="csv-dump">`) and downloaded. |
| `test_fail` | With `test=1`: `comp`, `comp1`, `captcha`, `instructed`, `recall`, `decline`. |
| `auto` | With `test=1`: `fill` answers each page but leaves Next to you; `off` does nothing. |
| `auto_delay` | With `test=1`: ms between pages (default 5). |
| `__pilotToken` | Added by Pavlovia when piloting. |

## Local test

```
cd "Stimuli/Paper Two/Pavlovia/A1"
python3 -m http.server 8000
```

Open `http://localhost:8000/index.html?test=1&code=12345` (automatic) or `http://localhost:8000/index.html?participant=PILOT_X&code=12345` (by hand). Local runs never contact Pavlovia; the CSV downloads instead.

Checks, from `Stimuli/Paper Two/Pavlovia/`:

```
python3 tools/run_headless_tests.py --study A1 --out /tmp/a1_runs   # 136 automatic sessions in headless Chrome
python3 tools/test_formulas_A1.py --csv-dir /tmp/a1_runs            # lists, formulas, saved data, columns
python3 tools/check_strings.py --study A1                           # every string against its source
python3 tools/session_length_A1.py                                  # timing rule of design record 1.13
```

## Data columns

One CSV per session, `data/PA_A1_<id>_SESSION_<date>.csv`, with one row per trial (10 rows), in the order the trials were shown. Participant-level columns repeat on every row. A session that ended before the trials (comprehension failed twice, captcha) has one row with the trial columns empty. Times are milliseconds. `_rt_ms` is the time from the screen appearing to the first answer to that item; `_rt_last_ms` to the last change; `_n_changes` counts changes. Lists inside a cell are separated by `;`. An item not asked on a trial is empty.

### Session and assignment

| Column | Meaning |
| --- | --- |
| `study_code` | `PA_A1`. |
| `engine_version` | Engine version string. |
| `config_version` | A1 configuration version string. |
| `participant_id` | SONA survey code (or PILOT/TEST id). |
| `code` | Numeric code used by the formulas (empty if the id is not numeric). |
| `is_test` | true for test mode or a PILOT/TEST id; dropped before analysis. |
| `test_mode` | true when `test=1`. |
| `test_fail` | Failure injected in test mode, if any. |
| `platform` | `sona`, `test`, or other. |
| `platform_source` | How the platform was decided (`numeric_id`, `url`, `test_mode`, `none`). |
| `pavlovia_session` | `open` (saved to Pavlovia), `local`, or `failed`. |
| `session_complete` | true only when the debriefing was reached. |
| `exit_reason` | `complete`, `comprehension_failed` or `captcha_failed`. |
| `start_time` | ISO time the page loaded. |
| `end_time` | ISO time of the end (or early exit). |
| `total_duration_ms` | Page load to end. Used for the one-third-of-the-median exclusion and the timing gate. |
| `row` | List k (0 to 9). |
| `list` | List k (same as `row`). |
| `n_rows` | 10. |
| `dropped_items` | `would_block` if the timing-gate remedy is in force. |
| `open_rows` | The open lists read from `open_rows.json`, in ascending order. |
| `n_open_rows` | Number of open lists. |
| `open_rows_index` | code mod n_open_rows (empty for a forced or random list). |
| `open_rows_source` | `file` or `fallback_all`; `_none_open_used_all` appended if the file listed no list. |
| `open_rows_updated` | The `updated` stamp of `open_rows.json`. |
| `assignment_source` | `code_mod_open_rows`, `url_row` or `random_no_numeric_code`. |
| `option_order_index` | floor(code / 10) mod 3. |
| `option_order` | Decision options in display order (`whole`, `part`, `refuse`). |
| `option_order_source` | `floor(code/10) mod 3` or `random_no_numeric_code`. |
| `item_order` | floor(code / 30) mod 2: 0 whole image first, 1 addition first (the covariate). |
| `item_order_label` | `whole_first` or `addition_first`. |
| `item_order_source` | `floor(code/30) mod 2` or `random_no_numeric_code`. |
| `recall_index` | floor(code / 60) mod 2. |
| `recall_index_source` | `floor(code/60) mod 2` or `random_no_numeric_code`. |
| `recall_position` | Slot of the story-recall trial (0 or 1). |
| `recall_story` | Its story (`ai` or `hand`), the correct recall answer. |
| `recall_scene` | Its scene. |
| `recall_file` | The first image shown again. |
| `follow_up_positions` | Slots shown again in the follow-up section, `6;7`. |
| `trial_order` | Slots in the order shown (block 1, then block 2). |
| `n_trials` | 10. |

### Trial (one row per trial)

| Column | Meaning |
| --- | --- |
| `trial_position` | 1 to 10, order of presentation (1 to 8 block 1, 9 and 10 block 2). |
| `list_position` | Slot j, 0 to 9 (same as `slot`). |
| `slot` | Slot j, 0 to 9. |
| `block` | 1 or 2. |
| `story` | `ai` (made with an AI image generator) or `hand` (painted by Alex). |
| `amount` | `none`, `small`, `medium` or `large`. |
| `cell` | `<story>_<amount>`. |
| `scene` | Scene shown (SA-R1 and SA-R2 are the reserves). |
| `scene_place` | The scene whose place it takes in the order (SA05 for SA-R1, SA08 for SA-R2; otherwise the scene itself). |
| `scene_position` | Its position (0 to 9) in the interleaved order. |
| `scene_has_person` | true for scenes with a person. |
| `source_file` | First image. |
| `second_file` | Second image (the source again on no-change trials, which show only the one image). |
| `has_addition` | true on change trials. |
| `has_follow_up` | true on slots 6 and 7, the trials of the follow-up section. |
| `story_page_ms` | Time on the trial's story page (at least 3 s). |
| `pre_page_ms` | Time on the page showing the first image alone. |
| `pre_image_load_ms` | Time until the first image had loaded (its 5-second minimum starts then). |
| `pre_image_error` | true if the first image failed to load. |
| `pre_min_view_ms` | 5000. |
| `trial_shown_at_ms` | Time since page load when the trial's change page appeared. |
| `view_page_ms` | Time on the change page (title, images, statement; no questions). |
| `image_load_ms` | Time until both images of the change page had loaded (the 10-second minimum starts then). |
| `image_error` | true if an image failed to load. |
| `min_view_ms` | 10000. |
| `question_page_ms` | Time on the question page (no minimum). |
| `trial_items` | Items asked on this trial's question page, in the order shown (the creativity definition and the block-2 rule reminder have no answer and are not listed). |
| `creativity_whole` | "...the whole second image, including what was already in the first image?" (no-change trials: "...this image?"), 1 (None at all) to 5 (A great deal). |
| `creativity_whole_rt_ms` | Time to first answer. |
| `creativity_whole_rt_last_ms` | Time to last change. |
| `creativity_whole_n_changes` | Number of changes. |
| `creativity_addition` | "...Alex's addition ([the added elements])?", 1 to 5 (change trials). |
| `creativity_addition_rt_ms` | Time to first answer. |
| `creativity_addition_rt_last_ms` | Time to last change. |
| `creativity_addition_n_changes` | Number of changes. |
| `decision` | Registration decision: `whole`, `part` or `refuse`. |
| `decision_rt_ms` | Time to first answer. |
| `decision_rt_last_ms` | Time to last change. |
| `decision_n_changes` | Number of changes. |
| `decision_display_pos` | Screen position (1 to 3) of the chosen option. |
| `followup` | After `part`: `first_image`, `added`, `something_else` or `not_sure`. |
| `followup_rt_ms` | Time to first answer. |
| `followup_rt_last_ms` | Time to last change. |
| `followup_n_changes` | Number of changes. |
| `confidence` | 0 to 100. |
| `confidence_rt_ms` | Time to first answer. |
| `confidence_rt_last_ms` | Time to last change. |
| `confidence_n_changes` | Number of value changes (dragging counts each step). |
| `share` | Authorship share, 0 to 100. |
| `share_rt_ms` | Time to first answer. |
| `share_rt_last_ms` | Time to last change. |
| `share_n_changes` | Number of value changes. |
| `jury` | Jury item, Yes or No (change trials). |
| `jury_rt_ms` | Time to first answer. |
| `jury_rt_last_ms` | Time to last change. |
| `jury_n_changes` | Number of changes. |
| `would_decision` | Follow-up section, "would" item: `whole`, `part` or `refuse` (rows of slots 6 and 7; empty if the timing-gate remedy dropped it). |
| `would_decision_rt_ms` | Time to first answer. |
| `would_decision_rt_last_ms` | Time to last change. |
| `would_decision_n_changes` | Number of changes. |
| `would_decision_display_pos` | Screen position of the chosen option. |
| `would_followup` | After `part`: as `followup`. |
| `would_followup_rt_ms` | Time to first answer. |
| `would_followup_rt_last_ms` | Time to last change. |
| `would_followup_n_changes` | Number of changes. |
| `would_confidence` | 0 to 100. |
| `would_confidence_rt_ms` | Time to first answer. |
| `would_confidence_rt_last_ms` | Time to last change. |
| `would_confidence_n_changes` | Number of changes. |
| `follow_up_would_page_ms` | Time on the trial's first follow-up page (the "would" item; empty if the timing-gate remedy dropped it). |
| `stop1` | Stop-others item 1, "They sell copies of the second image.", 1 to 7 (rows of slots 6 and 7). |
| `stop1_rt_ms` | Time to first answer. |
| `stop1_rt_last_ms` | Time to last change. |
| `stop1_n_changes` | Number of changes. |
| `stop2` | Item 2, take out what was added and sell the rest, 1 to 7. |
| `stop2_rt_ms` | Time to first answer. |
| `stop2_rt_last_ms` | Time to last change. |
| `stop2_n_changes` | Number of changes. |
| `stop3` | Item 3, a similar image made independently, 1 to 7. |
| `stop3_rt_ms` | Time to first answer. |
| `stop3_rt_last_ms` | Time to last change. |
| `stop3_n_changes` | Number of changes. |
| `stop4` | Item 4, the prompts Alex used typed into an AI image generator, 1 to 7 (row of slot 7 only, the AI page). |
| `stop4_rt_ms` | Time to first answer. |
| `stop4_rt_last_ms` | Time to last change. |
| `stop4_n_changes` | Number of changes. |
| `follow_up_stop_page_ms` | Time on the trial's second follow-up page (stop-others items). |
| `follow_up_order` | 1 or 2: the trial's place in the follow-up section (the order first seen). |
| `has_reason` | true on every trial (a written reason on every trial since 1 November 2026). |
| `written_reason` | The text. |
| `written_reason_rt_ms` | Time to the first keystroke. |
| `written_reason_chars` | Length of the text. |
| `written_reason_paste_attempts` | Blocked paste attempts. |
| `written_reason_page_ms` | Time on the written-reason page. |
| `written_reason_quote` | The decision quoted above the box ("You chose: “....”" and, after the divided option, "Left out: “....”"), tags removed. |
| `is_recall_trial` | true on the trial asked about in story recall. |

### Participant measures

| Column | Meaning |
| --- | --- |
| `device_type` | desktop or mobile (user agent). |
| `device_self_report` | 1 = desktop or laptop. |
| `user_agent` | Browser user agent. |
| `screen_width` | Screen width in pixels. |
| `screen_height` | Screen height in pixels. |
| `fullscreen_entered` | yes if the full-screen button was used. |
| `atlas_detected` | true if an automated browser was detected (session blocked). |
| `consent` | agreed. |
| `consent_time` | ISO time of consent. |
| `captcha_response` | q or z. |
| `captcha_pass` | true for q. |
| `captcha_rt_ms` | Time to the key press. |
| `comp1_attempt1` | Comprehension item 1, first attempt (True or False). |
| `comp1_attempt1_rt_ms` | Time to first answer. |
| `comp1_attempt1_correct` | Matches the key. |
| `comp2_attempt1` | Item 2, first attempt. |
| `comp2_attempt1_rt_ms` | Time to first answer. |
| `comp2_attempt1_correct` | Matches the key. |
| `comp3_attempt1` | Item 3, first attempt. |
| `comp3_attempt1_rt_ms` | Time to first answer. |
| `comp3_attempt1_correct` | Matches the key. |
| `comp_attempt1_pass` | All three correct on the first attempt. |
| `comp1_attempt2` | Item 1, retry (empty if not needed). |
| `comp1_attempt2_rt_ms` | Time to first answer. |
| `comp1_attempt2_correct` | Matches the key. |
| `comp2_attempt2` | Item 2, retry. |
| `comp2_attempt2_rt_ms` | Time to first answer. |
| `comp2_attempt2_correct` | Matches the key. |
| `comp3_attempt2` | Item 3, retry. |
| `comp3_attempt2_rt_ms` | Time to first answer. |
| `comp3_attempt2_correct` | Matches the key. |
| `comp_attempt2_pass` | All three correct on the retry. |
| `comp_failed_twice` | true if both attempts failed (session ended). |
| `instructed` | Answer to the instructed-response item. |
| `instructed_rt_ms` | Time to first answer. |
| `instructed_pass` | true only for "Somewhat disagree". |
| `instructed_after_trial` | 3. |
| `follow_up_intro_page_ms` | Time on the follow-up section's introductory page. |
| `rule_page_ms` | Time on the rule page. |
| `rule_recall1` | "...can one image be partly registered?": Yes, No or Not sure (internal-pilot gate). |
| `rule_recall1_rt_ms` | Time to first answer. |
| `rule_recall2` | "...can that person claim the image?": Yes, No or Not sure. |
| `rule_recall2_rt_ms` | Time to first answer. |
| `recall` | Story recall: `ai`, `hand` or `dont_remember`. |
| `recall_rt_ms` | Time to first answer. |
| `recall_correct_answer` | The recall trial's story. |
| `recall_correct` | true if the answer matches it. |
| `belief` | Story belief: Yes, Partly or No. |
| `belief_rt_ms` | Time to first answer. |
| `purpose_order` | Purpose-probe options in display order. |
| `purpose` | `split` (the true purpose), `quality_liking`, `tell_ai_painting`, `description_length` or `something_else`. |
| `purpose_rt_ms` | Time to first answer. |
| `ownership` | `alex`, `company`, `artists`, `no_one` or `not_sure`. |
| `ownership_rt_ms` | Time to first answer. |
| `exp_ai_tool` | Never, Once or twice, Sometimes, Often. |
| `exp_ai_tool_rt_ms` | Time to first answer. |
| `exp_photo` | No, Sometimes, Often, Professionally. |
| `exp_photo_rt_ms` | Time to first answer. |
| `exp_draw_paint` | No, Sometimes, Often, Professionally. |
| `exp_draw_paint_rt_ms` | Time to first answer. |
| `gaais_pos7` | Short GAAIS-10 item 7 of the full GAAIS (Positive: interested in using AI systems in daily life), 1 Strongly disagree to 5 Strongly agree, as answered. |
| `gaais_pos7_rt_ms` | Time to first answer. |
| `gaais_neg8` | Short GAAIS-10 item 8 of the full GAAIS (Negative: AI is sinister), 1 Strongly disagree to 5 Strongly agree, as answered. |
| `gaais_neg8_rt_ms` | Time to first answer. |
| `gaais_neg9` | Short GAAIS-10 item 9 of the full GAAIS (Negative: AI might take control of people), 1 Strongly disagree to 5 Strongly agree, as answered. |
| `gaais_neg9_rt_ms` | Time to first answer. |
| `gaais_neg10` | Short GAAIS-10 item 10 of the full GAAIS (Negative: AI is dangerous), 1 Strongly disagree to 5 Strongly agree, as answered. |
| `gaais_neg10_rt_ms` | Time to first answer. |
| `gaais_pos11` | Short GAAIS-10 item 11 of the full GAAIS (Positive: positive impacts on wellbeing), 1 Strongly disagree to 5 Strongly agree, as answered. |
| `gaais_pos11_rt_ms` | Time to first answer. |
| `gaais_pos12` | Short GAAIS-10 item 12 of the full GAAIS (Positive: AI is exciting), 1 Strongly disagree to 5 Strongly agree, as answered. |
| `gaais_pos12_rt_ms` | Time to first answer. |
| `gaais_neg15` | Short GAAIS-10 item 15 of the full GAAIS (Negative: shiver with discomfort about future uses), 1 Strongly disagree to 5 Strongly agree, as answered. |
| `gaais_neg15_rt_ms` | Time to first answer. |
| `gaais_pos17` | Short GAAIS-10 item 17 of the full GAAIS (Positive: society will benefit), 1 Strongly disagree to 5 Strongly agree, as answered. |
| `gaais_pos17_rt_ms` | Time to first answer. |
| `gaais_pos18` | Short GAAIS-10 item 18 of the full GAAIS (Positive: would like to use AI in own job), 1 Strongly disagree to 5 Strongly agree, as answered. |
| `gaais_pos18_rt_ms` | Time to first answer. |
| `gaais_neg19` | Short GAAIS-10 item 19 of the full GAAIS (Negative: people like me will suffer), 1 Strongly disagree to 5 Strongly agree, as answered. |
| `gaais_neg19_rt_ms` | Time to first answer. |
| `acb_uniquely_human` | Anthropocentric creativity beliefs, "Creativity is a uniquely human characteristic.", 1 Strongly disagree to 7 Strongly agree. |
| `acb_uniquely_human_rt_ms` | Time to first answer. |
| `acb_differentiate` | Anthropocentric creativity beliefs, "Humans differentiate themselves from other species because of their ability to create.", 1 Strongly disagree to 7 Strongly agree. |
| `acb_differentiate_rt_ms` | Time to first answer. |
| `acb_essence` | Anthropocentric creativity beliefs, "Creativity is the essence of being human.", 1 Strongly disagree to 7 Strongly agree. |
| `acb_essence_rt_ms` | Time to first answer. |
| `acb_core` | Anthropocentric creativity beliefs, "Creativity is at the core of being human.", 1 Strongly disagree to 7 Strongly agree. |
| `acb_core_rt_ms` | Time to first answer. |
| `acb_only_humans` | Anthropocentric creativity beliefs, "Only humans have the ability to be creative.", 1 Strongly disagree to 7 Strongly agree. |
| `acb_only_humans_rt_ms` | Time to first answer. |
| `know1` | "A work must be registered before it is protected." (key False). |
| `know1_rt_ms` | Time to first answer. |
| `know1_correct` | Matches the key. |
| `know2` | Ideas as well as expression (key False). |
| `know2_rt_ms` | Time to first answer. |
| `know2_correct` | Matches the key. |
| `know3` | Working harder (key False). |
| `know3_rt_ms` | Time to first answer. |
| `know3_correct` | Matches the key. |
| `know4` | Changes to an unprotected work (key True). |
| `know4_rt_ms` | Time to first answer. |
| `know4_correct` | Matches the key. |
| `know5` | A machine as legal author (key False). |
| `know5_rt_ms` | Time to first answer. |
| `know5_correct` | Matches the key. |
| `age` | Years. |
| `age_rt_ms` | Time to first keystroke. |
| `gender` | Male, Female, Other, Prefer not to say. |
| `gender_rt_ms` | Time to first answer. |
| `race` | Selected options, `;`-separated. |
| `race_rt_ms` | Time to first answer. |
| `native_language` | Free text. |
| `native_language_rt_ms` | Time to first keystroke. |
| `art_training` | Paper One's five levels of formal artistic training. |
| `art_training_rt_ms` | Time to first answer. |
| `seriousness` | "No, I didn't" or "Yes, I did". |
| `seriousness_rt_ms` | Time to first answer. |
| `fullscreen_maintained` | "No, it wasn't." or "Yes, it was.". |
| `fullscreen_maintained_rt_ms` | Time to first answer. |
| `feedback_procedure` | Free text (or NA). |
| `feedback_procedure_rt_ms` | Time to first keystroke. |
| `feedback_procedure_chars` | Length. |
| `feedback_procedure_paste_attempts` | Blocked paste attempts. |
| `feedback_other` | Free text (or NA). |
| `feedback_other_rt_ms` | Time to first keystroke. |
| `feedback_other_chars` | Length. |
| `feedback_other_paste_attempts` | Blocked paste attempts. |
| `knowledge_score` | Number of the five quiz items answered correctly. |
| `purpose_chose_true` | true if the true purpose was chosen (for the purpose-probe rerun). |
| `gaais_positive` | Mean of the five Positive Short GAAIS-10 items (1 to 5); empty unless all were answered. |
| `gaais_negative` | Mean of the five Negative items reverse-scored (6 minus the answer), so that higher means more forgiving of AI's drawbacks, as the scale's authors score it. |
| `acb_score` | Mean of the five anthropocentric creativity belief items (1 to 7). |
| `excl_comprehension` | Failed the comprehension items twice. |
| `excl_captcha` | Failed the captcha trap. |
| `excl_instructed` | Failed the instructed-response item. |
| `excl_recall` | Wrong story recall ("I don't remember" counts as wrong). |
| `excl_any_in_page` | Any of the four above. Not included: speed, earlier participation and repeat sessions, applied by `../tools/update_open_rows.py`. |
| `page_timestamps` | JSON list of `{p, id, t}`: page index, page id, ms since load. |
| `n_pages` | Pages built for the session. |

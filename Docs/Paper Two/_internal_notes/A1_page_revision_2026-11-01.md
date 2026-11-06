# A1 page revision, 1 November 2026

David walked through A1 on Pavlovia on 1 November 2026, before filing, and asked for clearer pages. This file fixes every change and every new participant-facing string. It is the source for the preregistration edits (Prereg_A1.md), the design record entry 12.25, and the page code (Pavlovia/A1/config.js and the shared engine). Strings in quotation marks below are verbatim; `**...**` marks bold.

His four decisions (AskUserQuestion, 1 November 2026): amount labels for the creativity scale; keep the jury item, reworded; drop the per-trial belief check and the two believability ratings; the debriefing says in one line that Alex and his stories were invented.

A second pass the same day (section 13) moved the written reason and the "would" item into one follow-up section with the stop-others items, so every trial has the same two pages, and fixed four lines a participant would find odd. Section 13 replaces sections 5, 6 and 8 and the strings it names in sections 2, 3, 4, 7 and 9. A third change the same day (section 14) puts a written reason on every trial, so every trial has the same three pages; it replaces section 13's placement of the written reason. A fourth (section 15) walks participants through each trial in five pages, names the AI an "AI image generator" throughout, puts Paper One's definition inside each creativity question, and replaces the single attitude item with two end scales.

Unchanged: the scenes, images, lists, slots, cells, option orders, creativity-item order, story-recall assignment, comprehension items, captcha, device check, instructed-response item (after the third block-1 trial), rule-recall items, story-belief item, purpose probe, experience, knowledge, demographics and final items; every confirmatory test, model, bound, criterion, sample size and simulation file. No simulation is rerun.

## 1. One sentence per line

Every participant-facing text of more than one sentence is shown one sentence per paragraph: primer, story, trial statements, decision question, rule, intro pages, debriefing. Implemented in config.js as arrays of sentences (not by splitting in the engine, which would break "U.S." and "No. 25-449").

## 2. Primer (adds the fact comprehension item 2 tests)

- "In this study you will see images and read how they were made."
- "A person can apply to the U.S. Copyright Office to register a work as their own."
- "The Office reviews each application and decides whether to register the work."
- "Registering a work does not sell it."
- "It creates a public record that names the work's author."

It still omits that copyright protects works made by people.

## 3. Story

- "Alex is a digital artist."
- "He made some of the first images below with an AI image tool, by writing prompts for it."
- "He painted the others himself with digital painting tools, without any AI tool."
- "He has not published, sold, or registered any of these images."
- "Before each image you will be told how he made it."
- "For a few images, you will also be asked to explain your answer."

## 4. Trial: two pages (replaces the first-image-alone page and the single trial page)

Page 1, the change page: centered title, both images (captions "First image", "Second image"), the statement one sentence per line. Minimum 10 seconds from image load (the 8-second first-image page is removed). Bold is identical in form under both stories.

- Title, AI story: "First image: made by Alex **with an AI image tool**"
- Title, hand-made story: "First image: **painted by Alex himself, without any AI tool**"
- Statement, change trials, three lines: "Alex then made a second version himself, with his digital painting tools and without any AI tool." / "He added **{phrase}**." / "He changed nothing else."
- Statement, no-change trials: "Alex then looked at the image again and decided to keep it as it was."

{phrase} is the scene's element for the amount (large: the medium element, then the two further elements), as before. The statement still depends on scene and amount only, never on the story.

Page 2, the question page: the same title, images and statement above the questions, no minimum time. Items in this order:

1. The creativity definition once, above both creativity items: "Creativity is defined as the presence of at least a minimal original, intellectual contribution to the creation of the work."
2. The two creativity items in the participant's order (the addition item on change trials only):
   - "How much creativity went into making the second image as a whole?"
   - "How much creativity went into making Alex's addition ({phrase})?"
   - Scale: 1 "None at all", 2 "A little", 3 "A moderate amount", 4 "A lot", 5 "A great deal".
3. Block 2 only, above the decision: "Remember the rule: when a person builds on material that is not theirs to claim, such as an image an AI system generated from their own prompts, the Office registers only what that person added."
4. Decision, three lines: "Alex applies to the U.S. Copyright Office to register the second image as his own work, naming himself as its author." / "His application describes how both images were made, as you have just read." / "What should the Office do?" Options, follow-up ("Which part should be left out of the registration?") and confidence item unchanged.
5. Share, unchanged: "How much of the second image is Alex's own creative work?" (none of it, all of it).
6. Jury item, change trials only: "Does Alex's addition show at least a small amount of creativity?" (Yes / No). Still follows the minimal-creativity interrogatory of Eleventh Circuit Pattern Civil Jury Instruction 9.2.

Removed: the per-trial belief check ("Do you believe Alex made this change by hand, as described?").

## 5. Written reason (slots 2 and 7, unchanged; replaced by section 13)

Its own page, right after that trial's question page, with the same title, images and statement. Above the box, the participant's answer quoted: "You chose: “{decision label}”." and, after the divided option, a second line: "Left out: “{follow-up label}”." Then: "In a sentence or two, why did you choose this answer about what the Office should do?" Free text, required, pasting disabled.

## 6. Stop-others section (moved out of block 1; now part of the follow-up section, section 13)

After the last block-1 trial and before the rule. Reason: block-1 trial order is random, so a stop-others page on one large-addition trial ("take out what was added...") could precede the other large-addition trial's decision, one of the two cells gate G compares.

- Intro page: "Here are two images you saw earlier." / "We have a few more questions about each."
- Then slots 6 and 7 (block 1, hand-made and AI at the large addition), in the order first seen. Each page: title, images, statement, then "Suppose another person does the following without asking Alex." and each scenario followed by its own question "Should Alex be able to stop them?" on a 1-to-7 scale (definitely not, definitely yes):
  - item 1 "They sell copies of the second image."
  - item 2 "They take out what was added in the second version, and sell what is left."
  - item 3 "Without ever seeing Alex's image, they make a similar image on their own."
  - item 4, AI page only: "They type the prompts Alex used for the first image into an AI image tool and sell the image they get."
- Answers are recorded on the row of the trial they concern (stop1 to stop3 on slots 6 and 7; stop4 on slot 7). Item 4 leaves the end pages.

## 7. Rule page

- "Before the last two images, here is a rule the U.S. Copyright Office follows."
- "When a person builds on material that is not theirs to claim, the Office registers only what that person added and leaves the rest out."
- "Material that is not theirs to claim includes images an AI system generated, even from that person's own prompts, and paintings whose copyright has expired."
- "So one image can be partly registered."

Minimum 5 seconds, then the two rule-recall items, unchanged.

## 8. "Would" block (removed; the "would" item is in the follow-up section, section 13)

- Intro page: "You will now see two images from earlier again." / "This time the question is different: not what the Office should do, but what you think it would actually do under current law."
- Then slots 2 and 7 in the order first seen, each on one page (title, images, statement; no first-image page, no minimum time) with: "Under current U.S. law, what do you think the Copyright Office would actually do?", the decision options in the participant's order, the follow-up and the confidence item.

## 9. Story recall

Same item and scoring; the page adds one line above the image: "One last question about an image you saw earlier."

## 10. End pages

Story belief (unchanged), purpose probe (unchanged), ownership, experience, knowledge, demographics, final items. Removed: the two believability ratings. Ownership, one question, no intro line: "Think about the first images Alex made with an AI image tool, from his prompts." / "Before he changed them, who, if anyone, owned the copyright in those images?" (Alex / The company that makes the AI tool / Artists whose work the AI tool learned from / No one / Not sure).

## 11. Debriefing

- "Thank you for taking part."
- "This study asks how people divide credit for an image that one person built on another image, and whether it matters if the first image was made by AI."
- "The U.S. Copyright Office registers only the parts of a work that a person made and leaves AI-generated material out."
- "That practice assumes people can separate a person's part of an image from the rest."
- "Your answers help test whether people judge this way."
- "Alex and his stories were invented for this study, and every image was made with an AI image model."
- then the contact line.

LAW_AS_OF and ALLEN_STATUS leave A1's config. B1's debriefing changes with B1's own revision.

## 12. Preregistration consequences

- Procedure, Measured items, Randomization (stop-others now a section), debriefing and session-length estimate rewritten to match.
- H2's zero-state condition: refit on participants who answered "Yes" to the story belief item (the per-trial belief condition goes).
- Secondary: "story belief and rule recall as moderators" (believability and the per-trial check go).
- The creativity bound (.224 scale points) and every confirmatory result are unchanged: the scale keeps five points and the same items enter the same models.

## 13. Second pass: the follow-up section (1 November 2026; its written reason replaced by section 14)

David asked why only two trials had a written reason, wanted every image treated the same way, and asked what the rule reminder in block 2 adds. His decision (AskUserQuestion, 1 November 2026): "One return", all extra questions in one section after block 1, on the same two trials.

Reasons. The written reason inside block 1 had the problem that moved the stop-others items out of it: trial order is random, so a reason written on one trial could come before another trial's decision, including the two large-addition trials that G compares, and explaining a choice changes the answers that follow (design record, table of decisions). Asked after block 1, no extra item precedes any block-1 answer. Asked before the rule, the "would" item records what people believe current practice is, as section 1.5.12 of the design record intends ("would" measures knowledge, "should" endorsement), not whether they apply a rule just stated. The two trials are slots 6 and 7, the block-1 large-addition trials under each story, so the written reasons now bear on G, and the "would" item falls on two cells with a determinate key (the contested AI-small cell is kept out of agreement totals anyway).

Every trial: the change page and the question page, nothing else (no reason page).

Follow-up section, after the last block-1 trial and before the rule:

- Intro page: "Here are two images you saw earlier." / "We have a few more questions about each."
- Slots 6 and 7 in the order first seen; both pages of one trial before the next trial's. Each page shows the trial's title, images and statement.
- Page 1 (`follow_up_office`):
  - plain line: "This time, the question is what the Office would actually do, not what it should do."
  - "Under current U.S. law, what do you think the Copyright Office would actually do?" with the decision's options in the participant's order, the follow-up ("Which part should be left out of the registration?") and the confidence item;
  - a box quoting the participant's decision on that trial: "When we asked earlier what the Office **should** do, you chose: “{decision label}.”" and, after the divided option, "Left out: “{follow-up label}.”" (American punctuation, the period inside the quotation marks);
  - "In a sentence or two, why did you choose that answer?" Free text, required, pasting disabled.
- Page 2 (`follow_up_stop`): the stop-others stem and items as in section 6, item 4 on the AI page only.
- The line, the "would" item, its follow-up and its confidence carry the drop group `would_block`: the timing-gate remedy (`DROP_ITEMS = ['would_block']`) removes them and leaves the written reason on page 1.

Strings changed elsewhere:

- Primer, a sixth line, so comprehension item 3 tests a sentence the primer states: "You will be asked what the Office should do with some applications."
- Story: "He made some of the first images you will see with an AI image tool, by writing prompts for it." (was "below"); the line "For a few images, you will also be asked to explain your answer." is removed.
- Rule page, first line: "Before the next two images, here is a rule the U.S. Copyright Office follows." (was "the last two images"; earlier images come back at story recall).
- Rule reminder on block-2 question pages, a box in normal weight, one sentence per line, the rule page's own words: "**Remember the rule.**" / "When a person builds on material that is not theirs to claim, the Office registers only what that person added and leaves the rest out." / "Material that is not theirs to claim includes images an AI system generated, even from that person's own prompts, and paintings whose copyright has expired." What it adds: block 2 asks whether people use the divided option once they know the rule; with the rule on screen, an answer reflects use of the rule, not memory of it.
- Story recall line: "One more question about an image you saw earlier." (was "One last", with seven pages after it).

Data columns (trial rows of slots 6 and 7): `would_decision`, `would_followup`, `would_confidence` (each with `_rt_ms`, `_rt_last_ms`, `_n_changes`; the decision with `_display_pos`), `written_reason_quote`, `written_reason` (with `_rt_ms`, `_rt_last_ms`, `_n_changes`, `_chars`, `_paste_attempts`), `follow_up_office_page_ms`, the stop-others answers, `follow_up_stop_page_ms`, `follow_up_order`; participant level `follow_up_intro_page_ms`; derived `follow_up_positions`; trial flag `has_follow_up`. Removed: `has_reason`, `written_reason_page_ms`, `would_shown`, `would_order`, `would_page_ms`, `would_block_shown`, `would_intro_page_ms`, `reason_positions`, `stop_positions`, `has_stop_items`, `stop_others_order`, `stop_others_page_ms`, `stop_others_intro_page_ms`.

Engine 1.3.0 adds what this needs, each unused by B1: several pages per revisited trial (`pages`), the quoted decision above a named item (`quoteBefore`), drop groups (`dropGroup`), and an optional in-trial written reason and "would" block.

Preregistration: Procedure (the follow-up section; every trial two pages; primer sentence; comprehension items each test a primer sentence), Randomization (slots 6 and 7 only), Data collection (session length, about 23 minutes: ten trials 10.5, follow-up section 3.5, fixed parts 8.8; the timing-gate remedy removes the "would" item from the section), Manipulated (story, rule's first line), Measured (item 2's box; items 7 "would", 8 written reason, 9 stop-others in the section; 10 rule recall; 11 story recall's line), Secondary (the "would" item before the rule; confound with the follow-up section), Exploratory (written-reason counts by story). Items 1 to 6 and 11 to 19 keep their numbers.

## 14. A written reason on every trial (1 November 2026)

David did not want to lose the reason on the AI small-addition trial that section 13 gave up, and asked for a reason on every trial instead: "I would rather make it longer and ensure that this is fine. We also have approval for over 30 minutes." (The consent form already says the session takes less than 60 minutes.)

- Every trial has three pages: the change page, the question page and the written-reason page, nothing else. The written-reason page shows the trial's title, images and statement; above the box, the decision quoted: "You chose: “{decision label}.”" and, after the divided option, "Left out: “{follow-up label}.”" (American punctuation); then "In a sentence or two, why did you choose this answer about what the Office should do?" Free text, required, pasting disabled. Last on its trial, so writing it cannot change that trial's answers. Explaining can make later answers more deliberate; asked on every trial, under both stories and at every amount, it cannot by itself create G, S1 or S2.
- Story, a sixth line again: "For each image, you will also be asked to explain your answer."
- Follow-up section: page 1 (`follow_up_would`) keeps the line, the "would" item, its follow-up and confidence, all in the drop group `would_block`; page 2 the stop-others items. With the timing-gate remedy, page 1 is skipped and the section shows only the stop-others pages.
- Session about 29 minutes (ten trials with their reasons 18.0, follow-up section 2.0, fixed parts 8.8), posted as 45; the timing gate becomes a median of at most 45 minutes (`update_open_rows.py`, A1 `pilot_minutes` 45).
- Data: `has_reason` true and `written_reason`, `written_reason_rt_ms`, `written_reason_chars`, `written_reason_paste_attempts`, `written_reason_page_ms`, `written_reason_quote` on every trial row (the in-trial written reason of engine 1.2.0, with `reason_positions` 0 to 9 in `derive()`, not saved as a column); `follow_up_would_page_ms` replaces `follow_up_office_page_ms`. A1 config 1.4.0 on engine 1.3.0 (no engine change).
- Preregistration: Procedure (three pages per trial; the follow-up section's first page asks only the "would" item), Manipulated (story), Measured (item 7 the written reason on every trial; 8 "would"; 9 stop-others), Data collection (session length, posted length, timing gate), Exploratory (written-reason counts by cell).

## 15. Walk-through of each trial, wording, and two end scales (1 November 2026)

David walked through A1 on Pavlovia again and asked that participants be walked through each trial rather than shown both images at once, with the questions beside the images so that the images stay in view; asked why the creativity definition stood above the questions rather than within them; asked whether "AI tool" was the right name; and asked whether to add the GAAIS and an authenticity scale. His decisions (AskUserQuestion, 1 November 2026): "Story, image, change"; "AI image generator"; "Short GAAIS + beliefs". The authenticity scale of Carson, Hanel and Van Tilburg (the six-item state authenticity scale of Horton, Bailey and Iyengar, 2025) asks creators how they felt making their own work, so it does not fit studies whose participants judge Alex's images; it waits for a study in which participants create.

Each trial, five pages and nothing else:

1. Story page, at least 3 seconds, centered: AI: "Alex made the next image **with an AI image generator**." / "He wrote prompts, and the generator made the image from them." Hand-made: "Alex **painted the next image himself**." / "He used his digital painting tools and did not use any AI."
2. The first image alone, labeled "First image", at least 5 seconds from image load.
3. Change page, at least 10 seconds from image load: the title ("First image: made by Alex **with an AI image generator**" or "First image: **painted by Alex himself, without using any AI**"), then the statement, then both images side by side and large.
4. Question page, no minimum: the title and the two images, one above the other, in a column that stays in view (width the smaller of 46 percent and three quarters of the window height less 240 pixels, so both images fit beside the Next row; checked at 1440 by 900 and 1280 by 720), and beside it the statement in a light box and the items. Each creativity item now carries Paper One's definition below its question, as in Paper One and B1 (`q-def`), and the separate definition above the items is gone.
5. The written reason, laid out the same way.

Wording, "AI image generator" (Paper One's term) throughout: the story ("He made some of the first images you will see with an artificial intelligence (AI) image generator, a program that makes images from written descriptions called prompts." / "He painted the others himself with digital painting tools, without using any AI."), titles, statements ("...with his digital painting tools and without using any AI."), the rule ("...includes images made by an AI image generator, even from that person's own prompts, and paintings whose copyright has expired."), rule recall 2 ("...and an AI image generator makes an image from them..."), stop-others item 4, story recall, story belief ("...without using any AI?"), ownership and its options ("The company that makes the AI image generator", "Artists whose work the AI image generator learned from"), experience ("...with an AI image generator?"), and the debriefing ("...every image was made with an AI image generator."). The legal quotations in the answer keys keep their sources' words.

End scales, replacing the single attitude item ("In general, how do you feel about AI image tools?"), after experience and before the knowledge quiz, each on a wide page as a grid:

- The Short GAAIS-10 (Schepman & Rodway, 2026): the instructions for participants of the full GAAIS's ready-to-use appendix (Schepman & Rodway, 2023), one sentence per line, then the ten items in that appendix's order and wording (Pos7, Neg8, Neg9, Neg10, Pos11, Pos12, Neg15, Pos17, Pos18, Neg19), answered Strongly disagree, Disagree, Neutral, Agree, Strongly agree (1 to 5). Scores: `gaais_positive`, the mean of the Positive items; `gaais_negative`, the mean of the Negative items reverse-scored (higher is more forgiving of AI's drawbacks); no total. The 2026 paper's Supplementary Information 1 (its recommended order and instructions) could not be downloaded from the publisher; the 2023 appendix supplies both.
- Anthropocentric creativity beliefs (Millet, Buehler, Du & Kokkoris, 2023): "To what extent do you agree or disagree with the following statements?" and the five items of the authors' Study 3 materials, 1 Strongly disagree to 7 Strongly agree; `acb_score`, their mean.

The sources are in `_internal_notes/scale_sources/` with a README.

Data: per trial `story_page_ms`, `pre_page_ms`, `pre_image_load_ms`, `pre_image_error`, `pre_min_view_ms`; per participant `gaais_<item>` and `acb_<item>` with `_rt_ms`, and `gaais_positive`, `gaais_negative`, `acb_score`; `attitude` removed. Engine 1.4.0 (`trialStory`, `questionLayout: 'side'`, `wide` item pages; B1 unchanged); A1 config 1.5.0.

Session about 33 minutes (ten trials 19.6, follow-up section 2.0, fixed parts 11.0), still posted as 45.

## 16. No-change trials show one image; the whole-image item reworded (2 November 2026)

Keith Holyoak's pilot run of A1 (1 November 2026) stopped on trial 1, a no-change trial: two identical images and questions about "the second image" read as if Alex were registering a copy, and "the second image as a whole" was unclear. David chose to keep the no-change trials and show them as one image (they hold the prompts-alone anchor: AI, refuse; painted, register the whole; neither confirmatory test uses them), and to reword the whole-image item.

- No-change trials (slots 0 and 1, block 1): the first-image page shows the image unlabeled; the change page and later pages show it alone under "Made by Alex **with an AI image generator**" or "**Painted by Alex himself, without using any AI**", with the unchanged statement "Alex then looked at the image again and decided to keep it as it was."
- Their questions ask about "this image": "How much creativity went into making this image?"; "Alex applies to the U.S. Copyright Office to register this image as his own work, naming himself as its author. His application describes how it was made, as you have just read. What should the Office do?" (Register the whole image as Alex's work / Register only part of the image as Alex's work, and leave out the rest / Refuse to register it), with no follow-up; confidence; "How much of this image is Alex's own creative work?" Same item ids, so the same data columns.
- Trials with an addition: "How much creativity went into making the whole second image, including what was already in the first image?" (was "...the second image as a whole?"). It rates the same thing and says outright that the first image's content is inside it, the lay form of the work an application covers against the person's contribution, which the addition item rates.
- Engine 1.7.0 (an id may have two wordings, with one set of columns; the written-reason quote uses the trial's wording); A1 config 1.6.0; B1 unchanged (its checks pass under 1.7.0).

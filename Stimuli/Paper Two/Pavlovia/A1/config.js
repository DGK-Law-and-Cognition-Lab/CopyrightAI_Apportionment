// ============================================================
// Paper A, Study 1 (A1): study configuration for the shared engine
// ============================================================
//
// Every participant-facing study string below is copied from the
// preregistration, Docs/Paper Two/_source/Prereg_A1.md (version of
// 1 November 2026), whose page text follows the change specification
// Docs/Paper Two/_internal_notes/A1_page_revision_2026-11-01.md (David's
// walk-through of 1 November 2026: one sentence per line, two pages per trial,
// no per-trial belief check or believability ratings, the new debriefing; in
// its section 13, the follow-up section after block 1; in its section 14, a
// written reason on every trial; and, in its section 15, a walk-through of each
// trial (a story page, the first image alone, the change, then the questions
// beside the images), "AI image generator" throughout, and Paper One's
// creativity definition inside each creativity question, and two end scales:
// the Short GAAIS-10 and Millet et al.'s anthropocentric creativity beliefs);
// the scales' wording from their sources (see END_SCALES below); the scenes' added elements from
// Docs/Paper Two/Paper_Two_Prompt_Bank.md (Set A rows, with the dated phrase
// amendments of 28 and 29 October 2026 and the reserves SA-R1 and SA-R2); the
// consent form from Docs/IRB/V2_CONSENT FORM_Survey.docx (the form Paper One's
// Qualtrics surveys showed under IRB #24-001292); demographics and final
// questions from Paper One's Study 1 survey file
// (Analysis/R Analysis Pipeline/Study 1/qualtrics/Final_-_AI_Copyright_-_Study_1.qsf)
// and Docs/IRB/V1_DebriefandDemographicQuestions.docx. Screen furniture
// (buttons, device check, full screen, captcha, completion) is B1's, from the
// genre-study template. tools/check_strings.py --study A1 compares these
// strings with their sources.
//
// Values David must set before launch are marked SET BEFORE LAUNCH.
// ============================================================

window.STUDY_CONFIG = (function () {
  'use strict';

  // ---------- Values David must set or check before launch ----------

  // SET BEFORE LAUNCH: the credit-granting URL of the A1 SONA listing,
  // ending in "survey_code=" (SONA > study > Website > completion URL). The
  // participant's code is appended. Left empty, SONA sessions end on the
  // completion page instead of granting credit automatically.
  var SONA_CREDIT_URL_BASE = '';

  // Timing-gate remedy (registration, Data collection: internal pilot). Leave
  // empty. If the timing gate fails, set ['would_block'] for later
  // participants: it removes the "would" item (its line, decision, follow-up
  // and confidence) from the follow-up section, the only part A1 may drop for
  // time; the section then shows only the stop-others pages.
  var DROP_ITEMS = [];

  // A participant who declines consent saves no data and is sent to the
  // credit link (registration, Data collection).
  var CREDIT_ON_DECLINE = true;

  // ---------- Scenes (registration: Materials, Randomization) ----------

  // The interleaved order, positions 0 to 9: even positions hold scenes with
  // a person. SA-R2 (no person) takes SA08's position and SA-R1 (person)
  // SA05's, under the prompt bank's rescue rule (design record 12.19).
  // Added elements, verbatim from the bank's current Set A rows; "large" is
  // the two further elements added to the medium file.
  var SCENES = [
    { id: 'SA01', place: 'SA01', person: true,
      small: 'a spoon beside the cup',
      medium: 'a vase of daisies on the bare end of the table',
      large: 'a loaf of bread on a board, and a cat asleep on a stool' },
    { id: 'SA06', place: 'SA06', person: false,
      small: 'a duck on the empty stretch of water',
      medium: 'a heron standing in the shallow water',
      large: 'a second boat, and a stand of reeds' },
    { id: 'SA02', place: 'SA02', person: true,
      small: 'a gull standing on the wooden crate',
      medium: 'a dog lying on the empty dock to the man\'s right',
      large: 'a stack of barrels, and a lantern on a post' },
    { id: 'SA07', place: 'SA07', person: false,
      small: 'a single walnut',
      medium: 'a pear on the bare right side of the table',
      large: 'a bowl of grapes, and a candlestick' },
    { id: 'SA03', place: 'SA03', person: true,
      small: 'a bird flying in the open sky',
      medium: 'a dog running beside the two children',
      large: 'a picnic blanket with a basket, and a second kite' },
    { id: 'SA-R2', place: 'SA08', person: false,
      small: 'a milk churn beside the hay wagon',
      medium: 'a haystack on the open right side of the field',
      large: 'a grazing horse, and a stone water trough' },
    { id: 'SA04', place: 'SA04', person: true,
      small: 'a sheet of music on the floor',
      medium: 'a large dog asleep on the rug in front of the man',                                   // amended 28 October 2026
      large: 'a side table with a vase in the right foreground, and a candlestick on the side table' },  // amended 29 October 2026
    { id: 'SA09', place: 'SA09', person: false,
      small: 'a butterfly over the path',
      medium: 'a watering can on the path',
      large: 'a wheelbarrow, and a birdbath' },
    { id: 'SA-R1', place: 'SA05', person: true,
      small: 'a teacup on a saucer beside the scissors',
      medium: 'a basket of folded cloth on the bare left end of the table',
      large: 'a tall wooden cupboard against the back wall, and a rocking chair beside the table' },   // amended 28 October 2026
    { id: 'SA10', place: 'SA10', person: false,
      small: 'a single gull',
      medium: 'a large sailing ship in the open sea',                                                // amended 28 October 2026
      large: 'a rowboat, and a flare in the sky' }
  ];
  var SCENE_BY_ID = {};
  SCENES.forEach(function (s, i) { s.position = i; SCENE_BY_ID[s.id] = s; });

  // ---------- Slots, stories and statements (registration: Procedure, Manipulated, Randomization) ----------

  // Slot j of every list: block, story and amount.
  var SLOTS = [
    { block: 1, story: 'ai', amount: 'none' },      // 0
    { block: 1, story: 'hand', amount: 'none' },    // 1
    { block: 1, story: 'ai', amount: 'small' },     // 2
    { block: 1, story: 'hand', amount: 'small' },   // 3
    { block: 1, story: 'hand', amount: 'medium' },  // 4
    { block: 1, story: 'ai', amount: 'medium' },    // 5
    { block: 1, story: 'hand', amount: 'large' },   // 6
    { block: 1, story: 'ai', amount: 'large' },     // 7
    { block: 2, story: 'ai', amount: 'large' },     // 8
    { block: 2, story: 'hand', amount: 'large' }    // 9
  ];
  var REASON_SLOTS = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];   // a written reason on every trial
  var FOLLOW_UP_SLOTS = [6, 7];   // block 1, large addition: the cells G compares

  // The centered title of every page that shows a trial's images; the bold
  // part names the story, in the same form under both stories.
  var TITLE = {
    ai: 'First image: made by Alex <strong>with an AI image generator</strong>',
    hand: 'First image: <strong>painted by Alex himself, without using any AI</strong>'
  };
  // The story page before each trial: how Alex made the first image, two
  // sentences in the same form under both stories, the key words in bold.
  var TRIAL_STORY = {
    ai: ['Alex made the next image <strong>with an AI image generator</strong>.',
      'He wrote prompts, and the generator made the image from them.'],
    hand: ['Alex <strong>painted the next image himself</strong>.',
      'He used his digital painting tools and did not use any AI.']
  };
  // No-change trials show the one image (specification section 16): a title
  // without "First image", and no caption.
  var TITLE_ONE = {
    ai: 'Made by Alex <strong>with an AI image generator</strong>',
    hand: '<strong>Painted by Alex himself, without using any AI</strong>'
  };
  var CAPTION_FIRST = 'First image';
  var CAPTION_SECOND = 'Second image';
  // Statements, one sentence per line; {phrase} is the added elements, in bold.
  var STATEMENT_CHANGE = ['Alex then made a second version himself, with his digital painting tools and without using any AI.',
    'He added <strong>{phrase}</strong>.', 'He changed nothing else.'];
  var STATEMENT_NONE = ['Alex then looked at the image again and decided to keep it as it was.'];

  // The element(s) named for an amount: the large amount names the medium
  // element and then the two further elements (prompt bank, Set A).
  function addedPhrase(scene, amount) {
    if (amount === 'large') return scene.medium + ', ' + scene.large;
    return scene[amount];
  }
  // The statement depends on scene and amount only, never on the story.
  function statementFor(sceneId, amount) {
    if (amount === 'none') return STATEMENT_NONE.slice();
    var phrase = addedPhrase(SCENE_BY_ID[sceneId], amount);
    return STATEMENT_CHANGE.map(function (l) { return l.replace('{phrase}', phrase); });
  }

  // List k (0 to 9): slot j shows the scene at position (j + k) mod 10.
  // Files: <scene>_source.jpg (first image) and <scene>_<amount>.jpg (second
  // image; the source itself on no-change trials).
  function buildRow(k) {
    var trials = [];
    for (var j = 0; j < 10; j++) {
      var s = SCENES[(j + k) % 10], sl = SLOTS[j];
      trials.push({
        list_position: j, slot: j, block: sl.block, story: sl.story, amount: sl.amount,
        cell: sl.story + '_' + sl.amount, scene: s.id, scene_place: s.place, scene_position: s.position,
        scene_has_person: s.person, source_file: s.id + '_source.jpg',
        second_file: s.id + '_' + (sl.amount === 'none' ? 'source' : sl.amount) + '.jpg',
        has_addition: sl.amount !== 'none', has_follow_up: FOLLOW_UP_SLOTS.indexOf(j) >= 0
      });
    }
    return { row: k, list: k, trials: trials };
  }

  // Per-participant choices from the code (registration, Randomization).
  var OPTION_ORDERS = [['whole', 'part', 'refuse'], ['part', 'refuse', 'whole'], ['refuse', 'whole', 'part']];
  var ITEM_ORDERS = ['whole_first', 'addition_first'];
  function derive(code, row, rnd) {
    var optIdx = code === null ? rnd(3) : Math.floor(code / 10) % 3;
    var itemOrder = code === null ? rnd(2) : Math.floor(code / 30) % 2;
    var recallIdx = code === null ? rnd(2) : Math.floor(code / 60) % 2;
    var recallTrial = row.trials[recallIdx];          // slot 0 (AI, no change) or slot 1 (hand-made, no change)
    return {
      option_order_index: optIdx,
      option_order: OPTION_ORDERS[optIdx],
      option_order_source: code === null ? 'random_no_numeric_code' : 'floor(code/10) mod 3',
      item_order: itemOrder,
      item_order_label: ITEM_ORDERS[itemOrder],
      item_order_source: code === null ? 'random_no_numeric_code' : 'floor(code/30) mod 2',
      recall_index: recallIdx,
      recall_index_source: code === null ? 'random_no_numeric_code' : 'floor(code/60) mod 2',
      recall_position: recallTrial.list_position,
      recall_story: recallTrial.story,
      recall_scene: recallTrial.scene,
      recall_file: recallTrial.source_file,
      reason_positions: REASON_SLOTS.slice(),
      follow_up_positions: FOLLOW_UP_SLOTS.slice()
    };
  }

  // ---------- Shared response scales ----------

  var DECISION_OPTIONS = {
    whole: 'Register the whole second image as Alex\'s work',
    part: 'Register only part of the second image as Alex\'s work, and leave out the rest',
    refuse: 'Refuse to register it'
  };
  // No-change trials: the same options about "the image".
  var DECISION_OPTIONS_ONE = {
    whole: 'Register the whole image as Alex\'s work',
    part: 'Register only part of the image as Alex\'s work, and leave out the rest',
    refuse: 'Refuse to register it'
  };
  var FOLLOW_UP_OPTIONS = [
    { value: 'first_image', label: 'What was in the first image' },
    { value: 'added', label: 'What was added or changed in the second version' },
    { value: 'something_else', label: 'Something else' },
    { value: 'not_sure', label: 'Not sure' }
  ];
  var FOLLOW_UP_TEXT = 'Which part should be left out of the registration?';
  var CONFIDENCE = { type: 'slider', text: 'How confident are you in that answer?', left: 'not at all', right: 'completely' };
  var CREATIVITY_DEF = 'Creativity is defined as the presence of at least a minimal original, intellectual contribution to the creation of the work.';
  var CREATIVITY_POINTS = [
    { value: 1, label: 'None at all' },
    { value: 2, label: 'A little' },
    { value: 3, label: 'A moderate amount' },
    { value: 4, label: 'A lot' },
    { value: 5, label: 'A great deal' }
  ];
  function yn(values) { return values.map(function (v) { return { value: v, label: v }; }); }
  function sevenPoint(id, text, low, high) {
    return { id: id, type: 'scale', text: text, anchors: [low, high],
      points: [1, 2, 3, 4, 5, 6, 7].map(function (v) { return { value: v }; }) };
  }

  // ---------- Trial items (registration, Measured; specification section 4) ----------

  // The rule paragraph shown between the blocks (registration, Manipulated:
  // Block); the reminder on block-2 trials repeats its two rule sentences.
  var RULE = [
    'Before the next two images, here is a rule the U.S. Copyright Office follows.',
    'When a person builds on material that is not theirs to claim, the Office registers only what that person added and leaves the rest out.',
    'Material that is not theirs to claim includes images made by an AI image generator, even from that person\'s own prompts, and paintings whose copyright has expired.',
    'So one image can be partly registered.'
  ];

  // Text in {phrase} is filled per trial from trialContent(t).vars.
  var Q = {
    // Paper One's definition below each creativity question, as in Paper One and B1.
    creativity_whole: { id: 'creativity_whole', type: 'scale', points: CREATIVITY_POINTS,
      text: ['How much creativity went into making the whole second image, including what was already in the first image?', '<span class="q-def">' + CREATIVITY_DEF + '</span>'] },
    creativity_addition: { id: 'creativity_addition', type: 'scale', points: CREATIVITY_POINTS,
      text: ['How much creativity went into making Alex\'s addition ({phrase})?', '<span class="q-def">' + CREATIVITY_DEF + '</span>'] },
    rule_reminder: { id: 'rule_reminder', type: 'note', className: 'boxed',
      text: ['<strong>Remember the rule.</strong>', RULE[1], RULE[2]] },
    decision: { id: 'decision', type: 'decision',
      text: ['Alex applies to the U.S. Copyright Office to register the second image as his own work, naming himself as its author.',
        'His application describes how both images were made, as you have just read.',
        'What should the Office do?'],
      options: DECISION_OPTIONS,
      followUp: { id: 'followup', text: FOLLOW_UP_TEXT, options: FOLLOW_UP_OPTIONS, showIf: 'part' } },
    confidence: Object.assign({ id: 'confidence' }, CONFIDENCE),
    share: { id: 'share', type: 'slider', text: 'How much of the second image is Alex\'s own creative work?', left: 'none of it', right: 'all of it' },
    jury: { id: 'jury', type: 'choice', text: 'Does Alex\'s addition show at least a small amount of creativity?', options: yn(['Yes', 'No']) }
  };
  // No-change trials ask about "this image": the same ids and scales, so the
  // same data columns; no follow-up after the divided option, since there is
  // no second version to divide by (specification section 16).
  var Q_ONE = {
    creativity_whole: { id: 'creativity_whole', type: 'scale', points: CREATIVITY_POINTS,
      text: ['How much creativity went into making this image?', '<span class="q-def">' + CREATIVITY_DEF + '</span>'] },
    decision: { id: 'decision', type: 'decision',
      text: ['Alex applies to the U.S. Copyright Office to register this image as his own work, naming himself as its author.',
        'His application describes how it was made, as you have just read.',
        'What should the Office do?'],
      options: DECISION_OPTIONS_ONE },
    share: { id: 'share', type: 'slider', text: 'How much of this image is Alex\'s own creative work?', left: 'none of it', right: 'all of it' }
  };
  // Every item of the question page, in a fixed order that sets the data
  // columns (the two notes, text without an answer, have none); the
  // no-change wordings come last and share their items' columns.
  var TRIAL_QUESTIONS = [Q.creativity_whole, Q.creativity_addition, Q.rule_reminder,
    Q.decision, Q.confidence, Q.share, Q.jury, Q_ONE.creativity_whole, Q_ONE.decision, Q_ONE.share];

  // The items of one trial's question page, in registered order. A no-change
  // trial (block 1 only) asks about "this image": creativity, decision and
  // confidence, share. A trial with an addition: the creativity items in the
  // participant's order, each with the definition below its question; in
  // block 2, the rule reminder above the decision; decision, follow-up and
  // confidence; share; the jury item.
  function trialQuestionsFor(t, d) {
    if (!t.has_addition) return [Q_ONE.creativity_whole, Q_ONE.decision, Q.confidence, Q_ONE.share];
    var qs = d.item_order === 0 ? [Q.creativity_whole, Q.creativity_addition] : [Q.creativity_addition, Q.creativity_whole];
    if (t.block === 2) qs.push(Q.rule_reminder);
    return qs.concat([Q.decision, Q.confidence, Q.share, Q.jury]);
  }

  // ---------- After block 1: the follow-up section (specification section 13) ----------

  // Slots 6 and 7 (block 1, large addition) shown again after the last block-1
  // trial and before the rule, in the order first seen, each on two pages
  // before the next: first the "would" item, then the stop-others items.
  // Coming after every block-1 decision, no item of the section can precede a
  // block-1 answer; coming before the rule, the "would" item asks what people
  // believe current law does. Answers are saved on the row of the trial they
  // concern.
  var WOULD_GROUP = 'would_block';      // the timing-gate remedy removes these items
  var WOULD = {
    note: { id: 'would_note', type: 'note', className: 'plain', dropGroup: WOULD_GROUP,
      text: 'This time, the question is what the Office would actually do, not what it should do.' },
    decision: { id: 'would_decision', type: 'decision', dropGroup: WOULD_GROUP,
      text: 'Under current U.S. law, what do you think the Copyright Office would actually do?',
      options: DECISION_OPTIONS,
      followUp: { id: 'would_followup', text: FOLLOW_UP_TEXT, options: FOLLOW_UP_OPTIONS, showIf: 'part' } },
    confidence: Object.assign({ id: 'would_confidence', dropGroup: WOULD_GROUP }, CONFIDENCE)
  };
  // The written reason on every trial: its own page right after the question
  // page, below the participant's decision quoted (and, after the divided
  // option, the part left out); last on its trial, so writing it cannot change
  // that trial's answers.
  var REASON_QUESTION = { id: 'written_reason', type: 'text', rows: 4,
    text: 'In a sentence or two, why did you choose this answer about what the Office should do?' };
  var REASON_QUOTE = { chosen: 'You chose: “{label}.”', followUp: 'Left out: “{label}.”' };

  var STOP_STEM = 'Suppose another person does the following without asking Alex.';
  var STOP_QUESTION = 'Should Alex be able to stop them?';
  function stopItem(id, scenario) { return sevenPoint(id, [scenario, STOP_QUESTION], 'definitely not', 'definitely yes'); }
  var STOP = {
    stem: { id: 'stop_stem', type: 'note', text: STOP_STEM },
    stop1: stopItem('stop1', 'They sell copies of the second image.'),
    stop2: stopItem('stop2', 'They take out what was added in the second version, and sell what is left.'),
    stop3: stopItem('stop3', 'Without ever seeing Alex\'s image, they make a similar image on their own.'),
    stop4: stopItem('stop4', 'They type the prompts Alex used for the first image into an AI image generator and sell the image they get.')
  };
  var FOLLOW_UP = [
    { id: 'follow_up_intro', paragraphs: ['Here are two images you saw earlier.', 'We have a few more questions about each.'] },
    { id: 'follow_up', revisit: function (t) { return t.has_follow_up; },
      pages: [
        { id: 'follow_up_would', questions: [WOULD.note, WOULD.decision, WOULD.confidence] },
        { id: 'follow_up_stop',
          questions: [STOP.stem, STOP.stop1, STOP.stop2, STOP.stop3, STOP.stop4],
          questionsFor: function (t) {          // item 4 only on the AI page (slot 7)
            var qs = [STOP.stem, STOP.stop1, STOP.stop2, STOP.stop3];
            if (t.story === 'ai') qs.push(STOP.stop4);
            return qs;
          } }
      ] }
  ];

  // ---------- Between the blocks (registration, Manipulated: Block; Measured: rule recall) ----------

  var BLOCKS = [
    { id: 1 },
    { id: 2, before: FOLLOW_UP.concat([
      { id: 'rule', minSeconds: 5, paragraphs: RULE },
      { id: 'rule_recall', items: [
        { id: 'rule_recall1', type: 'choice', text: 'According to the rule you just read, can one image be partly registered?', options: yn(['Yes', 'No', 'Not sure']) },
        { id: 'rule_recall2', type: 'choice', text: 'According to the rule, if a person writes prompts and an AI image generator makes an image from them, can that person claim the image?', options: yn(['Yes', 'No', 'Not sure']) }
      ] }
    ]) }
  ];

  // ---------- End scales (registration, Measured; specification section 15) ----------

  // The Short GAAIS-10 (Schepman & Rodway, 2026, Int. J. Hum.-Comput. Interact.
  // 42(17), 14499-14515, doi 10.1080/10447318.2025.2610446; CC BY-NC-ND): its ten
  // items, five Positive and five Negative, with the full GAAIS item numbers;
  // the item wording, the instructions for participants and the item order are
  // the full scale's ready-to-use appendix (Schepman & Rodway, 2023, Int. J.
  // Hum.-Comput. Interact. 39(13), 2724-2741, doi 10.1080/10447318.2022.2085400),
  // restricted to the ten items; responses as in the 2026 validation, coded 1
  // to 5, Negative items reverse-scored, two subscale means and no total.
  var GAAIS_INSTRUCTIONS = [
    'We are interested in your attitudes towards Artificial Intelligence.',
    'By Artificial Intelligence we mean devices that can perform tasks that would usually require human intelligence.',
    'Please note that these can be computers, robots or other hardware devices, possibly augmented with sensors or cameras, etc.',
    'Please complete the following scale, indicating your response to each item.',
    'There are no right or wrong answers.',
    'We are interested in your personal views.'
  ];
  var GAAIS_ROWS = [
    { id: 'pos7', label: 'I am interested in using artificially intelligent systems in my daily life.' },
    { id: 'neg8', label: 'I find Artificial Intelligence sinister.' },
    { id: 'neg9', label: 'Artificial Intelligence might take control of people.' },
    { id: 'neg10', label: 'I think Artificial Intelligence is dangerous.' },
    { id: 'pos11', label: 'Artificial Intelligence can have positive impacts on people\'s wellbeing.' },
    { id: 'pos12', label: 'Artificial Intelligence is exciting.' },
    { id: 'neg15', label: 'I shiver with discomfort when I think about future uses of Artificial Intelligence.' },
    { id: 'pos17', label: 'Much of society will benefit from a future full of Artificial Intelligence.' },
    { id: 'pos18', label: 'I would like to use Artificial Intelligence in my own job.' },
    { id: 'neg19', label: 'People like me will suffer if Artificial Intelligence is used more and more.' }
  ];
  var GAAIS_COLUMNS = ['Strongly disagree', 'Disagree', 'Neutral', 'Agree', 'Strongly agree']
    .map(function (l, i) { return { value: i + 1, label: l }; });
  // Anthropocentric creativity beliefs (Millet, Buehler, Du & Kokkoris, 2023,
  // Computers in Human Behavior 143, 107707, doi 10.1016/j.chb.2023.107707):
  // the five items and the 1-to-7 agreement scale of the authors' posted
  // materials (ResearchBox 361, Study 3 codebook and data), averaged.
  var ACB_ROWS = [
    { id: 'uniquely_human', label: 'Creativity is a uniquely human characteristic.' },
    { id: 'differentiate', label: 'Humans differentiate themselves from other species because of their ability to create.' },
    { id: 'essence', label: 'Creativity is the essence of being human.' },
    { id: 'core', label: 'Creativity is at the core of being human.' },
    { id: 'only_humans', label: 'Only humans have the ability to be creative.' }
  ];
  var ACB_COLUMNS = ['Strongly disagree', 'Disagree', 'Somewhat disagree', 'Neither agree nor disagree', 'Somewhat agree', 'Agree', 'Strongly agree']
    .map(function (l, i) { return { value: i + 1, label: l }; });

  // ---------- End items, in registered order (Measured; specification section 10) ----------

  var END_PAGES = [
    { id: 'belief', items: [
      { id: 'belief', type: 'choice', text: 'Did you believe that Alex painted some of the first images himself, without using any AI?', options: yn(['Yes', 'Partly', 'No']) }
    ] },
    { id: 'purpose', items: [
      { id: 'purpose', type: 'choice', text: 'Which of these do you think the study was mainly about?',
        shuffle: true, fixedLast: 1, orderColumn: 'purpose_order',
        options: [
          { value: 'split', label: 'Whether people split an image into the artist\'s part and the rest' },
          { value: 'quality_liking', label: 'Whether image quality affects liking' },
          { value: 'tell_ai_painting', label: 'Whether people can tell AI images from paintings' },
          { value: 'description_length', label: 'Whether the length of a description matters' },
          { value: 'something_else', label: 'Something else' }
        ] }
    ] },
    // Ownership, one question with no introductory line (stop-others item 4
    // moved to the follow-up section; the believability ratings removed).
    { id: 'ownership', items: [
      { id: 'ownership', type: 'choice',
        text: ['Think about the first images Alex made with an AI image generator, from his prompts.',
          'Before he changed them, who, if anyone, owned the copyright in those images?'],
        options: [
          { value: 'alex', label: 'Alex' },
          { value: 'company', label: 'The company that makes the AI image generator' },
          { value: 'artists', label: 'Artists whose work the AI image generator learned from' },
          { value: 'no_one', label: 'No one' },
          { value: 'not_sure', label: 'Not sure' }
        ] }
    ] },
    { id: 'experience', items: [
      { id: 'exp_ai_tool', type: 'choice', text: 'How often have you made images with an AI image generator?', options: yn(['Never', 'Once or twice', 'Sometimes', 'Often']) },
      { id: 'exp_photo', type: 'choice', text: 'Apart from casual snapshots, do you take photographs?', options: yn(['No', 'Sometimes', 'Often', 'Professionally']) },
      { id: 'exp_draw_paint', type: 'choice', text: 'Do you draw or paint?', options: yn(['No', 'Sometimes', 'Often', 'Professionally']) }
    ] },
    // The two end scales replace the single attitude item (specification section 15).
    { id: 'gaais', wide: true, items: [
      { id: 'gaais_instructions', type: 'note', className: 'plain', text: GAAIS_INSTRUCTIONS },
      { id: 'gaais', type: 'grid', rows: GAAIS_ROWS, columns: GAAIS_COLUMNS }
    ] },
    { id: 'creativity_beliefs', wide: true, items: [
      { id: 'acb', type: 'grid', text: 'To what extent do you agree or disagree with the following statements?', rows: ACB_ROWS, columns: ACB_COLUMNS }
    ] },
    { id: 'knowledge', items: [
      { id: 'know1', type: 'choice', text: 'A work must be registered before it is protected.', options: yn(['True', 'False']), key: 'False' },
      { id: 'know2', type: 'choice', text: 'Copyright protects ideas as well as the way they are expressed.', options: yn(['True', 'False']), key: 'False' },
      { id: 'know3', type: 'choice', text: 'Working harder on something makes it more likely to be protected.', options: yn(['True', 'False']), key: 'False' },
      { id: 'know4', type: 'choice', text: 'A person can hold copyright in changes they make to a work that is not itself protected.', options: yn(['True', 'False']), key: 'True' },
      { id: 'know5', type: 'choice', text: 'A machine can be the legal author of a work in the United States.', options: yn(['True', 'False']), key: 'False' }
    ] }
  ];

  // Demographics: Paper One's Study 1 survey items (registration, item 20).
  var DEMOGRAPHICS_PAGES = [
    { id: 'demographics', items: [
      { id: 'age', type: 'number', text: 'What is your age?', min: 16, max: 99 },
      { id: 'gender', type: 'choice', text: 'What is your gender?', options: yn(['Male', 'Female', 'Other', 'Prefer not to say']) },
      { id: 'race', type: 'checkbox', text: 'Choose one or more races that you consider yourself to be',
        options: yn(['White or Caucasian', 'Black or African American', 'American Indian/Native American or Alaska Native', 'Asian', 'Native Hawaiian or Other Pacific Islander', 'Other', 'Prefer not to say']) },
      { id: 'native_language', type: 'shorttext', text: 'What is your native language?' },
      { id: 'art_training', type: 'choice', text: 'What is your level of formal artistic training or experience, such as painting, drawing, sculpture, ceramics, photography, and/or film-video?',
        options: yn(['No formal training or experience', 'A little formal training or experience', 'Moderate formal training or experience', 'Extensive formal training or experience', 'Very extensive formal training or experience']) }
    ] }
  ];

  // Final questions: Paper One's Study 1 survey and the IRB debriefing form (registration, item 21).
  var FINAL_PAGES = [
    { id: 'final', items: [
      { id: 'seriousness', type: 'choice', text: 'Did you complete this experiment seriously throughout (without responding randomly)?', options: yn(['No, I didn\'t', 'Yes, I did']) },
      { id: 'fullscreen_maintained', type: 'choice', text: 'Was the browser in the full-screen mode throughout the experiment?', options: yn(['No, it wasn\'t.', 'Yes, it was.']) },
      { id: 'feedback_procedure', type: 'text', rows: 3, text: 'Was any part of the procedure unclear? Did you have any problems completing any of the tasks? If none, type NA.' },
      { id: 'feedback_other', type: 'text', rows: 3, text: 'Is there anything else you would like to share with us? If not, type NA.' }
    ] }
  ];

  return {
    studyCode: 'PA_A1',
    configVersion: 'A1 config 1.6.0 (2026-11-02; Prereg_A1.md of 2 November 2026, no-change trials show one image)',
    pageTitle: 'Artistic Perception Experiment',
    stimuliDir: 'stimuli/',
    openRowsFile: 'open_rows.json',
    nRows: 10,
    sonaCreditUrlBase: SONA_CREDIT_URL_BASE,
    creditOnDecline: CREDIT_ON_DECLINE,
    completionCode: 'ARTA1',
    contact: { name: 'David G. Kamper', email: 'davidgkamper@ucla.edu' },
    dropItems: DROP_ITEMS,
    // Each trial (specification section 15): the story page (at least 3 s),
    // the first image alone (at least 5 s from image load), the change page
    // (title and statement above the pair, at least 10 s from image load), the
    // question page (no minimum), the written reason.
    trialStory: function (t) { return { paragraphs: TRIAL_STORY[t.story].slice(), minSeconds: 3 }; },
    preScreen: { minViewSeconds: 5, content: function (t) {
      return { lines: [], images: [{ file: t.source_file, caption: t.has_addition ? CAPTION_FIRST : '' }] }; } },
    minViewSeconds: 10,                 // the change page, counted from image load
    viewPage: true,                     // the change page, then the question page (no minimum)
    pairLayout: 'top',                  // the change page: title, statement, then the pair, large
    pairMaxHeight: 'calc(100vh - 360px)',   // title, statement and Next stay on a 720-pixel screen
    pairTextBelow: false,
    questionLayout: 'side',             // pages with questions: the pair stacked in a column that stays in view

    scenes: SCENES,
    slots: SLOTS,
    titles: TITLE,
    titlesOneImage: TITLE_ONE,        // no-change trials (read by tools/dump_config.js)
    captions: [CAPTION_FIRST, CAPTION_SECOND],
    statementFor: statementFor,
    buildRow: buildRow,
    derive: derive,
    rowColumns: ['list'],
    derivedColumns: ['option_order_index', 'option_order', 'option_order_source', 'item_order', 'item_order_label', 'item_order_source',
      'recall_index', 'recall_index_source', 'recall_position', 'recall_story', 'recall_scene', 'recall_file', 'follow_up_positions'],
    trialColumns: ['slot', 'block', 'story', 'amount', 'cell', 'scene', 'scene_place', 'scene_position', 'scene_has_person',
      'source_file', 'second_file', 'has_addition', 'has_follow_up'],
    // Every page that shows the pair (change page, question page, written
    // reason, the two follow-up pages) shows the same title, images and
    // statement, so the story stays in view while the questions are answered.
    // vars fills {phrase} in the creativity item about the addition.
    trialContent: function (t) {
      if (!t.has_addition) {            // no change: the one image, no caption
        return { title: TITLE_ONE[t.story], statement: statementFor(t.scene, t.amount),
          images: [{ file: t.source_file }], vars: { phrase: '' } };
      }
      return { title: TITLE[t.story], statement: statementFor(t.scene, t.amount),
        images: [{ file: t.source_file, caption: CAPTION_FIRST }, { file: t.second_file, caption: CAPTION_SECOND }],
        vars: { phrase: t.has_addition ? addedPhrase(SCENE_BY_ID[t.scene], t.amount) : '' } };
    },
    blocks: BLOCKS,

    consent: {
      heading: 'Informed Consent',
      intro: 'Please read the form carefully before consenting.',
      url: '',
      sections: [
        { title: 'CONSENT FORM', paragraphs: ['You are invited to participate in a research study on human thinking and artistic and aesthetic judgment, conducted by Dr. Keith J. Holyoak, of the Department of Psychology at UCLA. You were selected as a possible participant in this study because you are 18 years of age or older.'] },
        { title: 'Purpose of Study', paragraphs: ['The purpose of the study is to understand human artistic perception and cognition.'] },
        { title: 'Procedures Involved in Study', paragraphs: ['If you agree to participate, you may receive a demographic questionnaire to collect information on your age, gender, language, and artistic background. You may be presented with different types of visual art and asked to answer simple questions and/or perform simple tasks by interacting with a website via a keyboard or a computer mouse. Your responses will be recorded by the computer and will not be identified with you in any way. The session will take less than 60 minutes.'] },
        { title: 'Potential Risks and Discomforts', paragraphs: ['There is no known risk or discomfort in this study. If you experience any discomfort during the experiment, you can stop at any time and notify the experimenter.'] },
        { title: 'Potential Benefits to Subject', paragraphs: ['There are no direct benefits from participating in this study.'] },
        { title: 'Potential Benefits to Society', paragraphs: ['The findings of the study will help us understand how humans perceive and understand aesthetic judgements in the law. By understanding the processes underlying human perception, we can better consider the fundamentals of copyright and the burgeoning field of AI art.'] },
        { title: 'Payment for Participation', paragraphs: ['You will receive 0.5 to 1 hour of credit for your psychology class if you signed up for the study through the UCLA Psychology Department Subject Pool; otherwise, you will receive payment at the rate of $16 per hour for your participation.'] },
        { title: 'Alternatives to Participation', paragraphs: ['An alternative to participating in this project and fulfilling Psychology 10 requirements is to participate in other research or to do an equivalent classroom project.'] },
        { title: 'Confidentiality', paragraphs: [
          'Your identity in this study will be treated as confidential. The results of the study, including laboratory or any other data, may be published for scientific purposes but will not include any identifiable references to you. Your data, including de-identified data, may be kept for use in future research. After the experiment has finished running, all contact information will be destroyed. Only the researchers will have access to registration and data files. The data files that you submit will be stored for 5 years.',
          'The researchers will do their best to ensure that your private information is kept confidential. Information about you will be handled as confidentially as possible, but participating in research may involve a loss of privacy and the potential for a breach in confidentiality. Study data will be physically and electronically secured. As with any use of electronic means to store data, there is a risk of breach of data security.'] },
        { title: 'Participation and Withdrawal', paragraphs: ['Your participation is VOLUNTARY. You may withdraw from the experiment at any time without suffering any negative consequences. You may refuse to answer any questions that you do not want to answer and remain in the study.'] },
        { title: 'Identification of Investigators', paragraphs: ['If you have any questions, feel free to contact Co-Principal Investigator David G. Kamper (davidgkamper@ucla.edu) or Principal Investigator Keith Holyoak (kholyoak@g.ucla.edu) at the Department of Psychology, UCLA, 405 Hilgard Ave., Los Angeles, CA 90095-1563.'] },
        { title: 'Rights of Research Subjects', paragraphs: ['You may withdraw your consent at any time and discontinue participation without penalty. You are not waiving any legal claims, rights, or remedies because of your participation in this research study.'] },
        { title: 'UCLA Office of the Human Research Protection Program (OHRPP)', paragraphs: ['If you have questions about your rights as a research subject, or you have concerns or suggestions and you want to talk to someone other than the researchers, you may contact the UCLA OHRPP by phone: (310) 206-2040; by email: participants@research.ucla.edu or by mail: Box 951406, Los Angeles, CA 90095-1406.'] }
      ],
      agree: 'I consent to this study.',
      decline: 'I do not consent to this study.'
    },

    // Primer, one sentence per line; each comprehension item tests a sentence
    // of it (item 1 the third, item 2 the fourth and fifth, item 3 the sixth).
    primer: { minSeconds: 5, paragraphs: [
      'In this study you will see images and read how they were made.',
      'A person can apply to the U.S. Copyright Office to register a work as their own.',
      'The Office reviews each application and decides whether to register the work.',
      'Registering a work does not sell it.',
      'It creates a public record that names the work\'s author.',
      'You will be asked what the Office should do with some applications.'
    ] },

    comprehension: {
      options: yn(['True', 'False']),
      items: [
        { id: 'comp1', text: 'The U.S. Copyright Office decides whether to register a work.', key: 'True' },
        { id: 'comp2', text: 'Registering a work with the Copyright Office means selling it.', key: 'False' },
        { id: 'comp3', text: 'In this study you will be asked what the Copyright Office should do with some applications.', key: 'True' }
      ],
      retryNotice: 'You did not answer every question correctly. Please read the text again.'
    },

    story: { minSeconds: 5, paragraphs: [
      'Alex is a digital artist.',
      'He made some of the first images you will see with an artificial intelligence (AI) image generator, a program that makes images from written descriptions called prompts.',
      'He painted the others himself with digital painting tools, without using any AI.',
      'He has not published, sold, or registered any of these images.',
      'Before each image you will be told how he made it.',
      'For each image, you will also be asked to explain your answer.'
    ] },

    trialQuestions: TRIAL_QUESTIONS,
    trialQuestionsFor: trialQuestionsFor,
    // The written reason on every trial (reason_positions), with the decision
    // quoted above it; no "would" block at the end (the "would" item is in
    // the follow-up section).
    reasonQuestion: REASON_QUESTION,
    reasonQuote: REASON_QUOTE,

    instructed: {
      id: 'instructed', afterTrial: 3,            // the third trial of block 1
      text: 'To show that you are reading each question, choose \'Somewhat disagree\' here.',
      options: yn(['Strongly disagree', 'Disagree', 'Somewhat disagree', 'Neither agree nor disagree', 'Somewhat agree', 'Agree', 'Strongly agree']),
      pass: 'Somewhat disagree'
    },

    // Story recall: the first image of slot 0 or 1 again, without its title,
    // below one line of introduction.
    recall: {
      id: 'recall',
      text: 'How was this first image made?',
      options: [
        { value: 'ai', label: 'With an AI image generator, from Alex\'s prompts' },
        { value: 'hand', label: 'Painted by Alex himself with digital painting tools' },
        { value: 'dont_remember', label: 'I don\'t remember' }
      ],
      correct: function (t) { return t.story; },        // "I don't remember" counts as wrong
      content: function (t) { return { lines: ['One more question about an image you saw earlier.'], images: [{ file: t.source_file }] }; }
    },

    endPages: END_PAGES,
    demographicsPages: DEMOGRAPHICS_PAGES,
    finalPages: FINAL_PAGES,
    extraColumns: ['knowledge_score', 'purpose_chose_true', 'gaais_positive', 'gaais_negative', 'acb_score'],
    finalize: function (r, trials, rec, get) {
      var score = 0, n = 0;
      ['know1', 'know2', 'know3', 'know4', 'know5'].forEach(function (k) {
        if (get(k + '_correct') !== undefined && get(k + '_correct') !== '') { n++; if (get(k + '_correct') === true) score++; }
      });
      rec('knowledge_score', n === 5 ? score : '');
      rec('purpose_chose_true', get('purpose') === undefined ? '' : get('purpose') === 'split');
      // Scale means (empty unless every item was answered): Short GAAIS-10
      // Positive; Negative reverse-scored (6 minus the answer), so that higher
      // means more forgiving of AI's drawbacks, as its authors score it; and
      // the anthropocentric creativity beliefs.
      function mean(ids, f) {
        var v = ids.map(function (k) { return get(k); });
        if (v.some(function (x) { return x === undefined || x === null || x === ''; })) return '';
        return Math.round(v.reduce(function (a, x) { return a + f(+x); }, 0) / v.length * 1000) / 1000;
      }
      function ids(prefix, rows, kind) { return rows.filter(function (x) { return !kind || x.id.indexOf(kind) === 0; }).map(function (x) { return prefix + x.id; }); }
      rec('gaais_positive', mean(ids('gaais_', GAAIS_ROWS, 'pos'), function (x) { return x; }));
      rec('gaais_negative', mean(ids('gaais_', GAAIS_ROWS, 'neg'), function (x) { return 6 - x; }));
      rec('acb_score', mean(ids('acb_', ACB_ROWS), function (x) { return x; }));
    },

    // The debriefing, one sentence per line (specification section 11), then
    // the contact line. A1's own text since 1 November 2026; B1's changes
    // with B1's own revision.
    debrief: {
      heading: 'Debriefing',
      paragraphs: [
        'Thank you for taking part.',
        'This study asks how people divide credit for an image that one person built on another image, and whether it matters if the first image was made by AI.',
        'The U.S. Copyright Office registers only the parts of a work that a person made and leaves AI-generated material out.',
        'That practice assumes people can separate a person\'s part of an image from the rest.',
        'Your answers help test whether people judge this way.',
        'Alex and his stories were invented for this study, and every image was made with an AI image generator.'
      ]
    },

    // Screen furniture: B1's strings (template strings unless marked new in B1/config.js).
    ui: {
      nextButton: 'Next →',
      completeButton: 'Complete Study →',
      waitButton: 'Please wait ({s}s)...',
      savingButton: 'Saving data...',
      selectOption: 'Please select an option.',
      answerAll: 'Please answer every item on this page before continuing.',
      deviceHeading: 'Device Check',
      deviceText1: 'This experiment must be completed on a <strong>desktop or laptop computer</strong>.',
      deviceText2: 'Are you currently using a desktop or laptop computer?',
      deviceYes: 'Yes, I am using a desktop or laptop computer',
      deviceNo: 'No, I am using a phone, tablet, or other device',
      desktopRequiredHeading: 'Desktop Required',
      desktopRequired1: 'We are sorry, but this experiment can only be completed on a desktop or laptop computer.',
      desktopRequired2: 'Please return to the study platform and try again from a computer. Thank you.',
      welcomeHeading: 'Welcome to the Artistic Perception Experiment',
      fullscreen1: 'For the best experience, we recommend completing this experiment in <strong>full-screen mode</strong>.',
      fullscreen2: 'Click the button below to enter full screen, then proceed.',
      fullscreenButton: 'Enter Full Screen',
      fullscreenDone: 'Full Screen Activated ✓',
      fullscreenNote: '(You can exit full screen at any time by pressing Esc)',
      consentLink: 'Click here to read the consent form ↗',
      captchaPrompt: 'Please follow the instruction in the image below.',
      captchaTrap: 'To continue, please press the letter Z on your keyboard.',
      captchaWaiting: 'Waiting for keypress...',
      captchaCorrect: 'Correct. Click Next to continue.',
      exitCaptchaHeading: 'Thank You',
      exitCaptcha: 'Thank you for your interest, but this experiment requires manual participation. Please click the button below to finish.',
      exitComprehensionHeading: 'Thank You',
      exitComprehension: 'This is the end of the session. Thank you for taking part. Please click the button below to save your responses and finish.',
      declinedHeading: 'Thank You',
      declinedText: 'You have chosen not to take part in this study. Thank you for your time.',
      closeWindow: 'You may now close this window.',
      blockedHeading: 'Study Unavailable',
      blockedText: 'This study cannot be completed using an automated browser.',
      contactLine: 'If you have any questions, please contact {name} at {email}.',
      saveInstruction: 'Please click the button below to save your responses and complete the study.',
      completeHeading: 'Study Complete',
      completeSaved: 'Thank you for participating. Your responses have been saved.',
      completeNotSaved: 'Thank you for participating. A copy of your data was downloaded to your computer; please email it to {email}.',
      completeNoSonaLink: 'Please keep the completion code below.',
      completionCodeLabel: 'Your completion code is:',
      loadErrorHeading: 'Study Could Not Load',
      loadErrorContact: 'Please try reloading the page. If the problem continues, contact {name} at {email}.',
      serverError: 'The study could not connect to its data server, so your answers would not be saved.',
      assignError: 'The study could not be set up on this computer.'
    }
  };
})();

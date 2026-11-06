# Sample-size simulation for Study A1 of Paper A, within-subjects design (Design Specification 12.3,
# approved 27 October 2026; 3.3 for everything 12.3 leaves unchanged), aligned with the A1
# registration (Docs/Paper Two/_source/Prereg_A1.md: Randomization, Analysis plan, Rationale).
#
# Every participant sees all ten Set A scenes, one condition per scene. Block 1 (no rule stated) has
# eight trials, source (AI, hand-made) x amount added (none, small, medium, large), one trial per
# cell. Block 2, after the rule paragraph, has two trials: AI with the large addition and hand-made
# with the large addition. Ten lists rotate the scenes through the cells. Samples: the target of 200
# analyzable participants (20 per list) and the fallback of 160 (16 per list). Each dataset is
# fitted with the registered mixed models:
#   - gate G (division model): logistic mixed model on "divided option chosen" over the eight
#     block-1 trials;
#   - instrument check (rule model): logistic mixed model on "divided option chosen" over the four
#     large-addition trials, two in each block;
#   - scope family (S1, S2): linear mixed model on the two creativity items stacked, block-1 change
#     trials.
# Every rival account of the scope family generates data; each contrast gets a state under the state
# rule and the share of datasets supporting each account is counted. G and the instrument check run
# under the planning scenarios of the registration and the five decision patterns of 3.3.
# Generating values are those of the registration's Rationale and 1.10, with the participant-by-cell
# SDs of 12.1.8 for every within-participant factor (source, amount, block).
#
# Logistic fits use bobyqa in both stages and treat a random-effect SD above 10 (log-odds) as a
# failure to converge (results/A1_convergence_note.md); linear fits use lme4's defaults. Both keep
# the registered convergence definition and removal rule (fit_registered() in sim_common.R).
#
# Usage: Rscript sim_A1.R [--reps 1000] [--reps_small 500] [--reps_laplace 200] [--cores N]
#                         [--date YYYY-MM-DD] [--quick]
#                         [--n_target N] [--n_fallback N] [--only main0,main1] [--tag TAG]
# Writes results/A1_sim.csv and results/A1_sim.md (with --tag, A1_sim_<TAG>.csv and .md).
# Smallest-sample search (12.12): --n_target and --n_fallback override the target and fallback
# (each a multiple of 10, the number of lists); --only limits the run to the named settings of the
# two families the search judges (the scope family and gate G under the main planning scenario,
# P(divided | AI, large) .30 against .15 and .15 against .15), writes results/A1_sim_<TAG>.csv with
# family, setting, generating, own_rate and max_rival_rate, and stops before the report.

# sim_common.R also defines script_dir(); this copy is needed to find sim_common.R first.
script_dir <- function() {
  args <- commandArgs(trailingOnly = FALSE)
  f <- sub("^--file=", "", args[grep("^--file=", args)])
  if (length(f)) dirname(normalizePath(f)) else getwd()
}
source(file.path(script_dir(), "sim_common.R"))

opt <- parse_args()
run_date <- if (!is.null(opt$date)) as.character(opt$date) else as.character(Sys.Date())
out_dir <- file.path(script_dir(), "results")
dir.create(out_dir, showWarnings = FALSE)
started <- Sys.time()
DEFAULT_REPS <- list(reps = 1000, reps_small = 500, reps_laplace = 200)

# ---------------------------------------------------------------- design

N_LIST <- 10
N_SCENE <- 10         # Set A: SA01-SA05 show a person, SA06-SA10 do not
N_TARGET <- 140       # 14 per list: the smallest candidate meeting the criteria (results/A1_search.md)
N_FALLBACK <- 120     # 12 per list: the candidate below the target (12.12)
# Smallest-sample search (12.12): --n_target and --n_fallback override these, --only limits the run
# to the named settings (for example main0,main1), and --tag adds a suffix to the output files.
if (!is.null(opt$n_target)) N_TARGET <- as.integer(opt$n_target)
if (!is.null(opt$n_fallback)) N_FALLBACK <- as.integer(opt$n_fallback)
TAG <- if (!is.null(opt$tag)) paste0("_", opt$tag) else ""
ONLY <- if (!is.null(opt$only)) strsplit(as.character(opt$only), ",")[[1]] else NULL
SEED_BASE <- 11e6
B_CRE <- 0.224        # creativity bound, 1-to-5 scale
B_PROB <- 0.10        # probability bound; G also needs its point estimate to reach it
IC_FAIL <- 0.20       # failing value of P(divided | AI, large, rule stated) for the instrument check
SENS <- 15 / 7        # sens15: participant-by-cell SDs raised by the factor that takes 7 points to 15

# Scenes in the interleaved order of 12.3: SA01, SA06, SA02, SA07, ..., SA05, SA10.
INTERLEAVED <- c(1, 6, 2, 7, 3, 8, 4, 9, 5, 10)

# The cell carried by each of the ten slots, as the registration's Randomization paragraph fixes
# them: slots 0 and 1 no change, 2 and 3 small, 4 and 5 medium, 6 and 7 large; the AI story on slots
# 0, 2, 5 and 7 and the hand-made story on 1, 3, 4 and 6; slot 8 AI and slot 9 hand-made, both
# large, in block 2. Source code: hand-made +0.5, AI -0.5; amount 0 = none, 1 = small, 2 = medium,
# 3 = large. Neighbouring slots alternate between scenes with and without a person, so each source
# in block 1 falls on two scenes of each kind and each amount on one of each kind, as do the
# written-reason trials (slots 2 and 7), the stop-others trials (6 and 7) and block 2 (8 and 9).
SLOTS <- data.frame(
  slot = 0:9,
  block = c(rep(1, 8), 2, 2),
  src = c(-0.5, 0.5, -0.5, 0.5, 0.5, -0.5, 0.5, -0.5, -0.5, 0.5),
  amount = c(0, 0, 1, 1, 2, 2, 3, 3, 3, 3))

# Amount codes are orthonormal polynomial contrasts. With them, independent participant-by-amount
# deviations of variance v are exactly uncorrelated slopes of variance v each, which is what the
# registered || terms assume.
P4 <- contr.poly(4)   # none, small, medium, large (decision, the eight block-1 trials)
P3 <- contr.poly(3)   # small, medium, large (creativity, the six block-1 change trials)

# Trials of one sample. List k puts the scene at position (j + k) modulo 10 of the interleaved order
# in slot j. Participants cycle through the lists, and the creativity item order alternates within
# each list (whole item first -0.5, addition first +0.5). Block is coded blk = -0.5 (block 1) and
# +0.5 (block 2); bidx (1, 2) indexes it. The rule model's data are the four large-addition trials,
# two in each block (slots 6, 7, 8 and 9).
make_design <- function(n) {
  if (n %% N_LIST != 0 || n < N_LIST) {
    stop(sprintf("sample %d is not a positive multiple of %d, the number of lists", n, N_LIST))
  }
  id <- seq_len(n)
  part <- data.frame(pid = id, list = (id - 1) %% N_LIST,
                     order = ifelse(((id - 1) %/% N_LIST) %% 2 == 0, -0.5, 0.5))
  tr <- merge(part, SLOTS, by = NULL)
  tr$scene <- INTERLEAVED[(tr$slot + tr$list) %% N_SCENE + 1]
  tr$person <- tr$scene <= 5
  tr$srcidx <- ifelse(tr$src > 0, 1, 2)   # 1 hand-made, 2 AI
  tr$bidx <- tr$block
  tr$blk <- ifelse(tr$block == 1, -0.5, 0.5)
  tr <- tr[order(tr$pid, tr$slot), ]
  rownames(tr) <- NULL
  dec1 <- tr[tr$block == 1, ]
  dec1$am1 <- P4[dec1$amount + 1, 1]
  dec1$am2 <- P4[dec1$amount + 1, 2]
  dec1$am3 <- P4[dec1$amount + 1, 3]
  dec2 <- tr[tr$block == 2, ]
  ch <- dec1[dec1$amount > 0, ]
  ch$am1 <- P3[ch$amount, 1]
  ch$am2 <- P3[ch$amount, 2]
  list(n = n, all = tr, dec1 = dec1, dec2 = dec2, ch = ch)
}

# The balance 12.1, 12.3 and the registration's Randomization paragraph require, checked before
# anything runs.
check_design <- function(D) {
  tr <- D$all
  stopifnot(all(table(tr$pid, tr$scene) == 1),                 # each scene once per person
            all(table(part_list = tr$list[tr$slot == 0]) == D$n / N_LIST),
            all(table(tr$list[tr$slot == 0], tr$order[tr$slot == 0]) == D$n / N_LIST / 2) ||
              (D$n / N_LIST) %% 2 == 1)                         # item order balanced within list
  one <- tr[!duplicated(tr[c("list", "slot")]), ]
  b1 <- one[one$block == 1, ]
  kind <- function(s) one$person[one$slot == s][order(one$list[one$slot == s])]
  stopifnot(all(table(one$scene, one$slot) == 1),               # every scene in every slot once
            all(table(b1$list, b1$src, b1$amount) == 1),        # each block-1 cell once per list
            all(table(b1$list, b1$src, b1$person) == 2),        # each source: 2 person, 2 not
            all(table(b1$list, b1$amount, b1$person) == 1),     # each amount: 1 of each kind
            all(table(one$list[one$block == 2], one$person[one$block == 2]) == 1),
            all(kind(2) != kind(7)),                            # written-reason trials: one of each
            all(kind(6) != kind(7)),                            # stop-others trials: one of each
            all(SLOTS$src[SLOTS$slot %in% c(0, 2, 5, 7, 8)] < 0),  # registration's story slots
            all(SLOTS$src[SLOTS$slot %in% c(1, 3, 4, 6, 9)] > 0),
            identical(SLOTS$amount, c(0, 0, 1, 1, 2, 2, 3, 3, 3, 3)))
}

DESIGNS <- list(target = make_design(N_TARGET), fallback = make_design(N_FALLBACK))
invisible(lapply(DESIGNS, check_design))

# Average fixed-effects design row over a grid of cells, built from the fixed formula alone (the
# same whichever random terms the fallback keeps), named like fixef().
fixed_row <- function(fixed, grid) {
  tt <- delete.response(terms(as.formula(fixed)))
  colMeans(model.matrix(tt, model.frame(tt, grid)))
}

# The full model fit_registered() tries first, written out for the report.
first_formula <- function(fixed, slopes, groups = c("pid", "scene")) {
  rhs <- sapply(groups, function(g) {
    v <- sub("^[^:]*:", "", slopes[sub(":.*$", "", slopes) == g])
    if (length(v)) sprintf("(1 + %s || %s)", paste(v, collapse = " + "), g) else sprintf("(1 | %s)", g)
  })
  paste(fixed, "+", paste(rhs, collapse = " + "))
}

term_id <- function(s) sub(":", "_", s, fixed = TRUE)

# What the registered fallback did in one fit: terms removed, removals after a convergence failure
# that was not also a singular fit, whether the scene intercept and each slope were kept.
fit_info <- function(f, slopes, pre = "") {
  v <- if (is.null(f$model)) rep(NA_real_, 4 + length(slopes))
       else c(f$removed, f$conv_removed, as.numeric(f$scene_int), as.numeric(isTRUE(f$grad_warn)),
              as.numeric(slopes %in% f$keep))
  setNames(v, paste0(pre, c("removed", "conv_removed", "scene_int", "grad_warn",
                            paste0("keep_", term_id(slopes)))))
}

# Reports which dataset failed, so that no dataset is dropped silently.
guard <- function(f, label) {
  function(r) tryCatch(f(r), error = function(e) {
    message(sprintf("  dataset %d of %s failed: %s", r, label, conditionMessage(e)))
    NULL
  })
}

# ---------------------------------------------------------------- scope family (S1, S2)

# Accounts exactly as in the 3.3 table; all three are rivals.
SCOPE_ACCOUNTS <- list(
  "Scoped credit, the Office's premise Q1, or a literal reading of each item" = list(
    key = "scoped_credit", allowed = list(S1 = "positive", S2 = "zero"), status = "rival"),
  "Taint, at any strength" = list(
    key = "taint", allowed = list(S1 = c("positive", "zero"), S2 = "positive"), status = "rival"),
  "Provenance ignored" = list(
    key = "provenance_ignored", allowed = list(S1 = "zero", S2 = "zero"), status = "rival"))
RIVALS <- names(SCOPE_ACCOUNTS)[sapply(SCOPE_ACCOUNTS, `[[`, "status") == "rival"]

# A contrast an account calls nonzero is set to `size`; one it allows to be zero is set to 0.
gen_values <- function(acc, size) {
  sapply(acc$allowed, function(a) {
    if (!"zero" %in% a && "positive" %in% a) size
    else if (!"zero" %in% a && "negative" %in% a) -size
    else 0
  })
}

# Generating values for the residue runs of 3.3 (S1 at 1.5 x bound, S2 at Paper One's residue).
RESIDUE <- list("S2 residue 0.10" = c(S1 = 1.5 * B_CRE, S2 = 0.10),
                "S2 residue 0.15" = c(S1 = 1.5 * B_CRE, S2 = 0.15))

# Creativity (1.10): participant SD 0.62, participant-by-item SD sd_item (on the addition item only,
# as in the planning simulation), scene SD 0.2, residual 0.7, scene-by-source deviations of SD sic
# shared by the two items, and participant-by-source deviations of SD sd_ps (12.1.8), also shared by
# the two items. Generated as normal and not rounded or clipped to 1-5, as in the planning simulation.
draw_creativity <- function(D, sic, sd_ps, sd_item) {
  n <- D$n
  u <- rnorm(n) * 0.62
  ups <- matrix(rnorm(n * 2) * sd_ps, n, 2)
  ui <- rnorm(n) * sd_item
  sv <- rnorm(N_SCENE) * 0.2
  dev <- matrix(rnorm(N_SCENE * 2) * sic, N_SCENE, 2)
  CH <- D$ch
  k <- nrow(CH)
  base <- 3 + u[CH$pid] + ups[cbind(CH$pid, CH$srcidx)] + sv[CH$scene] +
    dev[cbind(CH$scene, CH$srcidx)]
  list(whole = base + rnorm(k) * 0.7, add = base + ui[CH$pid] + rnorm(k) * 0.7)
}

# One dataset from the drawn noise. The label effect (hand-made minus AI) is S1 + S2 on the whole
# image and S2 on the addition, so S1 and S2 take their generating values.
creativity_data <- function(D, nz, S1, S2) {
  CH <- D$ch
  rbind(cbind(CH, item = 0.5, y = nz$whole + CH$src * (S1 + S2)),
        cbind(CH, item = -0.5, y = nz$add + CH$src * S2))
}

# Registered model (3.3 as changed by 12.3 and 1.8 revised): source x item x amount and item order;
# random intercepts for participant and scene, by-participant and by-scene slopes for the source,
# item and amount codes, all uncorrelated. Slopes are listed smallest generating variance first,
# scene before participant (scene amount 0, scene item 0, scene source 0 or 0.02; participant amount
# 0, participant item 0.0625, participant source 0.125); the order breaks ties and chooses the slope
# to remove when a fit stops with an error.
SCOPE_FIXED <- "y ~ src * item * (am1 + am2) + order"
SCOPE_SLOPES <- c("scene:am1", "scene:am2", "scene:item", "scene:src",
                  "pid:am1", "pid:am2", "pid:item", "pid:src")

# S2 is the label effect on the addition item and S1 the label effect on the whole-image item minus
# S2, each averaged over the three amounts.
grid3 <- data.frame(amount = 1:3, am1 = P3[, 1], am2 = P3[, 2], order = 0)
label_row <- function(item) {
  fixed_row(SCOPE_FIXED, transform(grid3, src = 0.5, item = item)) -
    fixed_row(SCOPE_FIXED, transform(grid3, src = -0.5, item = item))
}
SCOPE_L <- list(S1 = label_row(0.5) - label_row(-0.5), S2 = label_row(-0.5))

scope_fit <- function(d) {
  f <- fit_registered(SCOPE_FIXED, SCOPE_SLOPES, d)
  out <- c(S1_est = NA, S1_se = NA, S1_df = NA, S2_est = NA, S2_se = NA, S2_df = NA,
           fit_info(f, SCOPE_SLOPES))
  if (!is.null(f$model)) {
    b <- names(fixef(f$model))
    for (k in c("S1", "S2")) {
      ct <- tryCatch(lin_contrast(f$model, SCOPE_L[[k]][b]),
                     error = function(e) c(est = NA, se = NA, df = NA))
      out[paste0(k, c("_est", "_se", "_df"))] <- ct
    }
  }
  out
}

# One dataset of one setting: the same noise is used for every generating account (as in the
# planning simulation), and the residue runs use the first reps_small datasets of main0 and main1.
scope_rep <- function(rep, s) {
  set.seed(SEED_BASE + 1e5 * s$idx + rep)
  D <- DESIGNS[[s$design]]
  nz <- draw_creativity(D, s$sic, s$sd_ps, s$sd_item)
  gens <- lapply(SCOPE_ACCOUNTS, gen_values, size = s$mult * B_CRE)
  if (s$residue && rep <= opt$reps_small) gens <- c(gens, RESIDUE)
  do.call(rbind, lapply(names(gens), function(g) {
    t0 <- proc.time()[["elapsed"]]
    v <- gens[[g]]
    fit <- scope_fit(creativity_data(D, nz, v[["S1"]], v[["S2"]]))
    data.frame(setting = s$setting, generating = g, rep = rep,
               S1_true = v[["S1"]], S2_true = v[["S2"]], t(fit),
               S1 = state_of(fit[["S1_est"]], fit[["S1_se"]], fit[["S1_df"]], B_CRE),
               S2 = state_of(fit[["S2_est"]], fit[["S2_se"]], fit[["S2_df"]], B_CRE),
               sec = proc.time()[["elapsed"]] - t0, stringsAsFactors = FALSE)
  }))
}

# Settings. main0 and main1 (scene-by-source SD 0 and 0.10) at the target; bound0 and bound1
# (nonzero contrasts at the bound) and sens15 (participant-by-source and participant-by-item SDs
# raised from 0.25 by 15/7, the creativity counterpart of 7 to 15 points for share) at the target;
# fall0 and fall1 at the fallback.
SCOPE_SETTINGS <- data.frame(
  setting = c("main0", "main1", "bound0", "bound1", "sens15", "fall0", "fall1"),
  idx = 1:7,
  design = c(rep("target", 5), rep("fallback", 2)),
  mult = c(1.5, 1.5, 1, 1, 1.5, 1.5, 1.5),
  sic = c(0, 0.1, 0, 0.1, 0, 0, 0.1),
  sd_ps = c(rep(0.25, 4), 0.25 * SENS, 0.25, 0.25),
  sd_item = c(rep(0.25, 4), 0.25 * SENS, 0.25, 0.25),
  reps_kind = c("reps", "reps", rep("reps_small", 5)),
  residue = c(TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE),
  stringsAsFactors = FALSE)
SCOPE_SETTINGS$reps <- unlist(opt[SCOPE_SETTINGS$reps_kind])
SCOPE_SETTINGS$N <- sapply(SCOPE_SETTINGS$design, function(d) DESIGNS[[d]]$n)
# A search run (--only) keeps the named settings and skips the residue runs, which the search does
# not judge. Seeds come from idx, so a setting's datasets are the same with or without --only.
if (!is.null(ONLY)) {
  SCOPE_SETTINGS <- SCOPE_SETTINGS[SCOPE_SETTINGS$setting %in% ONLY, ]
  SCOPE_SETTINGS$residue <- FALSE
}

# ---------------------------------------------------------------- gate G and the instrument check

# G (12.3): source x amount over the eight block-1 trials, with item order (a counterbalancing
# factor, no slope); random intercepts for participant and scene, by-participant and by-scene slopes
# for the source and amount codes, uncorrelated. Slopes are listed smallest generating variance
# first, scene before participant (scene amount 0, scene source 0 or 0.18, participant amount 0.25
# each, participant source 0.5).
G_FIXED <- "y ~ src * (am1 + am2 + am3) + order"
G_SLOPES <- c("scene:am1", "scene:am2", "scene:am3", "scene:src",
              "pid:am1", "pid:am2", "pid:am3", "pid:src")

# Instrument check: the registration's rule model, on the four large-addition trials, two in each
# block (slots 6 and 7 in block 1, 8 and 9 in block 2): source x block and item order as fixed
# effects; a random intercept for participant and, for scene, a random intercept and uncorrelated
# slopes for the source and block codes. Four yes-or-no answers per person cannot support
# by-participant slopes (with them, participant SDs ran to 15 to 50 in most fits:
# results/A1_convergence_note.md), so the registration gives this model a participant intercept
# only (decided 28 October 2026). Scene slopes are listed smallest generating variance first.
RULE_FIXED <- "y ~ src * blk + order"
RULE_SLOPES <- c("scene:blk", "scene:src")

# Cells at the large addition, with the codes cell_tau2 needs, at the mean of item order.
large_cell <- function(src, weight) {
  a <- unname(P4[4, ])
  nr <- data.frame(src = src, am1 = a[1], am2 = a[2], am3 = a[3], order = 0)
  list(X = fixed_row(G_FIXED, nr), codes = c(src = src, am1 = a[1], am2 = a[2], am3 = a[3]),
       weight = weight)
}
G_CELLS <- list(large_cell(-0.5, 1), large_cell(0.5, -1))   # AI minus hand-made, block 1
IC_CELLS <- list(list(X = fixed_row(RULE_FIXED, data.frame(src = -0.5, blk = 0.5, order = 0)),
                      codes = c(src = -0.5, blk = 0.5), weight = 1))   # AI, large, block 2

# G passes when the population-averaged difference is positive at one-sided p < .05 and at least
# 0.10. The instrument check finds the divided option usable unless the upper end of the 95 percent
# interval for P(divided | AI, large, rule stated) is below 1/3.
g_pass <- function(est, se) is.finite(est) & is.finite(se) & se > 0 & est >= B_PROB &
  est / se > qnorm(0.95)
ic_pass <- function(est, se) is.finite(est) & is.finite(se) & est + qnorm(0.975) * se >= 1 / 3

# P(divided) for every cell: [source (hand-made, AI), block (1 no rule stated, 2 rule stated),
# amount (none, small, medium, large)]. Block 2 uses only the large amount.
pattern <- function(ai_ns, ai_st = ai_ns, hand_ns = rep(0.10, 4), hand_st = hand_ns) {
  a <- array(NA_real_, c(2, 2, 4))
  a[1, 1, ] <- hand_ns
  a[1, 2, ] <- hand_st
  a[2, 1, ] <- ai_ns
  a[2, 2, ] <- ai_st
  a
}

# The specification's generating values for the decision (3.3, "Sample size"); "rule stated" values
# are now block 2.
DECISION_PATTERNS <- list(
  "Office" = pattern(c(.05, .30, .60, .60), c(.10, .45, .65, .75)),
  "Area" = pattern(c(.05, .20, .40, .60), hand_ns = c(.05, .20, .40, .60)),
  "Taint" = pattern(rep(.10, 4)),
  "Scoped credit" = pattern(c(.05, .45, .60, .60)),
  "Provenance ignored" = pattern(rep(.10, 4)))
G_TRUE_PATTERNS <- c("Office", "Scoped credit")                 # true G 0.50
G_NULL_PATTERNS <- c("Area", "Taint", "Provenance ignored")    # true G 0

# The planning scenarios set only P(divided | large, block 1) for each source; the other cells,
# which the registered models also fit, take the Office's values.
scenario <- function(p_ai, p_hand) {
  a <- DECISION_PATTERNS$Office
  a[2, 1, 4] <- p_ai
  a[1, 1, 4] <- p_hand
  a
}

# Linear predictors that give each cell its population-averaged probability.
eta_array <- function(p, tau2) array(vapply(p, eta_for_pa, numeric(1), tau2 = tau2), dim(p))

# Random effects on the log-odds scale: participant (sd_p), participant-by-amount (sd_pa),
# participant-by-source (sd_ps), participant-by-block (sd_pb), scene (sd_s) and scene-by-source
# (sic). The participant-by-cell terms are independent deviations for each level of each
# within-participant factor (12.1.8). The same effects carry into block 2. Block 2 is drawn twice
# from the same effects and the same uniform draws: under the setting's own rule-stated values and
# with P(divided | AI, large, rule stated) set to IC_FAIL. The rule model's data are the two
# block-1 large trials with either version of block 2.
draw_decision <- function(D, s) {
  n <- D$n
  u <- rnorm(n) * s$sd_p
  upa <- matrix(rnorm(n * 4) * s$sd_pa, n, 4)
  ups <- matrix(rnorm(n * 2) * s$sd_ps, n, 2)
  sv <- rnorm(N_SCENE) * s$sd_s
  dev <- matrix(rnorm(N_SCENE * 2) * s$sic, N_SCENE, 2)
  upb <- matrix(rnorm(n * 2) * s$sd_pb, n, 2)
  re <- function(T) u[T$pid] + upa[cbind(T$pid, T$amount + 1)] + ups[cbind(T$pid, T$srcidx)] +
    upb[cbind(T$pid, T$bidx)] + sv[T$scene] + dev[cbind(T$scene, T$srcidx)]
  d1 <- D$dec1
  d1$y <- as.integer(runif(nrow(d1)) < plogis(s$eta[cbind(d1$srcidx, 1, d1$amount + 1)] + re(d1)))
  d2 <- D$dec2
  r2 <- re(d2)
  u2 <- runif(nrow(d2))
  eta2 <- s$eta[cbind(d2$srcidx, 2, d2$amount + 1)]
  d2f <- d2
  d2$y <- as.integer(u2 < plogis(eta2 + r2))
  d2f$y <- as.integer(u2 < plogis(ifelse(d2f$srcidx == 2, s$eta_fail, eta2) + r2))
  cols <- c("pid", "list", "slot", "scene", "src", "blk", "order", "y")
  big <- d1[d1$amount == 3, cols]
  rule <- rbind(big, d2[cols])
  rule_f <- rbind(big, d2f[cols])
  list(d1 = d1, rule = rule[order(rule$pid, rule$slot), ],
       rule_f = rule_f[order(rule_f$pid, rule_f$slot), ])
}

pa_or_na <- function(m, cells) tryCatch(pa_contrast(m, cells),
                                        error = function(e) c(est = NA, se = NA, df = Inf))

# Logistic fits (results/A1_convergence_note.md): the bobyqa optimizer in both stages of glmer, in
# place of lme4's default second stage (Nelder-Mead), which stops short of the optimum on these
# models; the registered convergence definition; and a fit whose largest random-effect SD exceeds
# 10 on the log-odds scale (a variance running off toward infinity) also fails to converge.
LOGIT_CONTROL <- glmerControl(optimizer = "bobyqa")
LOGIT_MAX_SD <- 10

g_fit <- function(d, nagq) {
  f <- fit_registered(G_FIXED, G_SLOPES, d, family = binomial(), nAGQ = nagq,
                      control = LOGIT_CONTROL, max_sd = LOGIT_MAX_SD)
  g <- if (is.null(f$model)) c(est = NA, se = NA) else pa_or_na(f$model, G_CELLS)
  c(G_est = g[["est"]], G_se = g[["se"]], fit_info(f, G_SLOPES, "G_"))
}

ic_fit <- function(d, nagq, pre) {
  f <- fit_registered(RULE_FIXED, RULE_SLOPES, d, family = binomial(), nAGQ = nagq,
                      control = LOGIT_CONTROL, max_sd = LOGIT_MAX_SD)
  ic <- if (is.null(f$model)) c(est = NA, se = NA) else pa_or_na(f$model, IC_CELLS)
  setNames(c(ic[["est"]], ic[["se"]], fit_info(f, RULE_SLOPES, "")),
           c(paste0(pre, c("_est", "_se")), paste0(pre, "_", names(fit_info(f, RULE_SLOPES)))))
}

# All fits of one dataset at one nAGQ: G (unless do_g is FALSE), the instrument check under the
# setting's values (IC) and under the failing value (ICf) (unless do_ic is FALSE).
dec_fits <- function(dd, nagq, do_g = TRUE, do_ic = TRUE) {
  t0 <- proc.time()[["elapsed"]]
  g <- if (do_g) g_fit(dd$d1, nagq)
       else setNames(rep(NA_real_, 2 + 3 + length(G_SLOPES)),
                     c("G_est", "G_se", names(fit_info(list(model = NULL), G_SLOPES, "G_"))))
  t1 <- proc.time()[["elapsed"]]
  ic_na <- function(pre) {
    nm <- c(paste0(pre, c("_est", "_se")),
            paste0(pre, "_", names(fit_info(list(model = NULL), RULE_SLOPES))))
    setNames(rep(NA_real_, length(nm)), nm)
  }
  ic <- if (do_ic) ic_fit(dd$rule, nagq, "IC") else ic_na("IC")
  icf <- if (do_ic) ic_fit(dd$rule_f, nagq, "ICf") else ic_na("ICf")
  t2 <- proc.time()[["elapsed"]]
  c(g, ic, icf, sec_G = t1 - t0, sec_IC = t2 - t1)
}

# One dataset of one G setting. The Laplace check (laplace = TRUE) draws the same dataset as the
# setting's main run (same seed) and fits it with nAGQ = 1 only; its nAGQ = 0 counterpart is the
# main run's row for the same dataset.
g_rep <- function(rep, s, laplace = FALSE) {
  set.seed(SEED_BASE + 1e5 * s$idx + rep)
  t0 <- proc.time()[["elapsed"]]
  dd <- draw_decision(DESIGNS[[s$design]], s)
  v <- if (laplace) dec_fits(dd, 1, do_g = s$laplace_g, do_ic = s$laplace_ic)
       else dec_fits(dd, 0, do_ic = is.null(ONLY))
  if (laplace) names(v) <- paste0(names(v), "_laplace")
  out <- data.frame(setting = s$setting, N = s$N, generating = s$generating, rep = rep, t(v),
                    stringsAsFactors = FALSE)
  out$sec <- proc.time()[["elapsed"]] - t0
  out
}

# Settings. Binary components of the registration's Rationale and 1.10 (participant SD 1.5, scene SD
# 0.4, participant-by-cell SD 0.5, scene-by-source SD 0 or 0.3), with the participant-by-cell SD
# applied to every within-participant factor (12.1.8): amount, source and block, 0.5 each. sens15
# raises the three participant-by-cell SDs by 15/7. The planning scenarios take the participant SD
# from the intraclass correlation and keep every other component, as the Rationale states ("For G,
# the participant standard deviation is instead set by an intraclass correlation").
bin_setting <- function(kind, setting, design, generating, p, idx, reps_kind, sic = 0, sens = 1,
                        sd_p = 1.5, sd_pa = 0.5, sd_s = 0.4, laplace = FALSE, laplace_g = FALSE,
                        laplace_ic = laplace) {
  sd_ps <- 0.5 * sens
  sd_pb <- 0.5 * sens
  sd_pa <- sd_pa * sens
  tau2 <- sd_p^2 + sd_pa^2 + sd_ps^2 + sd_pb^2 + sd_s^2 + sic^2
  list(kind = kind, setting = setting, design = design, N = DESIGNS[[design]]$n,
       generating = generating, idx = idx, reps_kind = reps_kind, reps = opt[[reps_kind]],
       sd_p = sd_p, sd_pa = sd_pa, sd_ps = sd_ps, sd_pb = sd_pb, sd_s = sd_s, sic = sic,
       eta = eta_array(p, tau2), eta_fail = eta_for_pa(IC_FAIL, tau2),
       true_G = p[2, 1, 4] - p[1, 1, 4], true_IC = p[2, 2, 4], laplace = laplace,
       laplace_g = laplace_g, laplace_ic = laplace_ic, icc = NA, p_ai = NA)
}

G_SETTINGS <- list()
add_g <- function(..., icc = NA, p_ai = NA) {
  s <- bin_setting(...)
  s$icc <- icc
  s$p_ai <- p_ai
  G_SETTINGS[[length(G_SETTINGS) + 1]] <<- s
}
PAT_SETTINGS <- list(
  list(setting = "main0", design = "target", sic = 0, sens = 1, reps_kind = "reps", idx = 11),
  list(setting = "main1", design = "target", sic = 0.3, sens = 1, reps_kind = "reps", idx = 16),
  list(setting = "sens15", design = "target", sic = 0, sens = SENS, reps_kind = "reps_small", idx = 23),
  list(setting = "fall0", design = "fallback", sic = 0, sens = 1, reps_kind = "reps_small", idx = 28),
  list(setting = "fall1", design = "fallback", sic = 0.3, sens = 1, reps_kind = "reps_small", idx = 33))
# Laplace check (nAGQ = 1, the registered fitting method) on the first reps_laplace datasets at
# main0: G and the instrument check under every pattern, and G under the planning scenarios at .30
# and .15 against .15 (below). With bobyqa in both stages a Laplace fit of G takes about half a
# minute a dataset (results/A1_convergence_note.md).
LAPLACE_G <- names(DECISION_PATTERNS)
for (ps in PAT_SETTINGS) {
  for (j in seq_along(DECISION_PATTERNS)) {
    add_g("pattern", ps$setting, ps$design, names(DECISION_PATTERNS)[j], DECISION_PATTERNS[[j]],
          ps$idx + j - 1, ps$reps_kind, sic = ps$sic, sens = ps$sens,
          laplace = ps$setting == "main0",
          laplace_g = ps$setting == "main0" && names(DECISION_PATTERNS)[j] %in% LAPLACE_G)
  }
}
# bound0 and bound1: the Office's values with P(divided | AI, large, block 1) at 0.20, so the true G
# (0.20 - 0.10) equals the bound.
BOUND_G <- "Office, G at the bound (AI 0.20 vs hand-made 0.10)"
add_g("bound", "bound0", "target", BOUND_G, scenario(0.20, 0.10), 21, "reps_small", sic = 0)
add_g("bound", "bound1", "target", BOUND_G, scenario(0.20, 0.10), 22, "reps_small", sic = 0.3)
# Planning scenarios of the registration's Rationale: P(divided | large, block 1) at .30 or .40 over
# AI sources against .15 over hand-made ones, or at equal rates (.15 against .15), with the
# participant SD set by an intraclass correlation of .25 or .50 (the share of log-odds variance
# between participants, participant intercept against the logistic variance pi^2 / 3). They run in
# the main settings (main0, main1: scene-by-source SD 0 and 0.3, at the target) and the fallback
# settings (fall0, fall1); .40 runs only without scene-by-source variation. The main scenario,
# .30 against .15, is the gate's row in the smallest-sample search, with .15 against .15 as its
# false-pass rate.
icc_sd <- function(icc) sqrt(icc / (1 - icc) * pi^2 / 3)
plan_label <- function(p_ai, icc) sprintf("P(divided | AI) %.2f vs hand-made 0.15, ICC %.2f", p_ai, icc)
PLAN_SETTINGS <- list(
  list(setting = "main0", design = "target", sic = 0, reps_kind = "reps"),
  list(setting = "main1", design = "target", sic = 0.3, reps_kind = "reps"),
  list(setting = "fall0", design = "fallback", sic = 0, reps_kind = "reps_small"),
  list(setting = "fall1", design = "fallback", sic = 0.3, reps_kind = "reps_small"))
k <- 40
for (ps in PLAN_SETTINGS) {
  for (icc in c(0.25, 0.50)) {
    for (p_ai in c(0.30, 0.40, 0.15)) {
      k <- k + 1
      if (p_ai == 0.40 && ps$sic > 0) next
      lap <- ps$setting == "main0" && p_ai %in% c(0.30, 0.15)
      add_g("planning", ps$setting, ps$design, plan_label(p_ai, icc), scenario(p_ai, 0.15), k,
            ps$reps_kind, sic = ps$sic, sd_p = icc_sd(icc), laplace = lap, laplace_g = lap,
            laplace_ic = FALSE, icc = icc, p_ai = p_ai)
    }
  }
}
stopifnot(!anyDuplicated(c(SCOPE_SETTINGS$idx, sapply(G_SETTINGS, `[[`, "idx"))))
# A search run (--only) keeps gate G's main planning scenario (.30 and .15 against .15) in the named
# settings, fitted at nAGQ = 0 only (no Laplace check), and skips the rest.
if (!is.null(ONLY)) {
  G_SETTINGS <- Filter(function(s) s$kind == "planning" && s$setting %in% ONLY &&
                         s$p_ai %in% c(0.30, 0.15), G_SETTINGS)
  G_SETTINGS <- lapply(G_SETTINGS, function(s) {
    s$laplace <- s$laplace_g <- s$laplace_ic <- FALSE
    s
  })
}

# ---------------------------------------------------------------- run

cat("A1: scope family\n")
scope_raw <- do.call(rbind, lapply(seq_len(nrow(SCOPE_SETTINGS)), function(i) {
  s <- SCOPE_SETTINGS[i, ]
  cat(sprintf("  %s, N = %d (%d datasets)\n", s$setting, s$N, s$reps))
  run_reps(s$reps, guard(function(r) scope_rep(r, s), s$setting), opt$cores)
}))

cat("A1: gate G and the instrument check\n")
g_raw <- do.call(rbind, lapply(G_SETTINGS, function(s) {
  cat(sprintf("  %s, N = %d, %s (%d datasets)\n", s$setting, s$N, s$generating, s$reps))
  run_reps(s$reps, guard(function(r) g_rep(r, s), paste(s$setting, s$generating)), opt$cores)
}))

LAP_SETTINGS <- Filter(function(s) s$laplace, G_SETTINGS)
if (length(LAP_SETTINGS)) cat("A1: Laplace check of G and the instrument check\n")
lap_raw <- do.call(rbind, lapply(LAP_SETTINGS, function(s) {
  cat(sprintf("  %s, %s (%d datasets)\n", s$setting, s$generating, opt$reps_laplace))
  run_reps(opt$reps_laplace, guard(function(r) g_rep(r, s, laplace = TRUE),
                                   paste("Laplace", s$setting, s$generating)), opt$cores)
}))

# Datasets that produced no row (an error outside the fits); the run must have none.
n_got <- function(raw, setting, generating = NULL) {
  x <- raw[raw$setting == setting & (is.null(generating) | raw$generating %in% generating), ]
  length(unique(x$rep))
}
dropped <- data.frame(
  family = c(rep("scope", nrow(SCOPE_SETTINGS)), rep("G and instrument check", length(G_SETTINGS)),
             rep("Laplace check", length(LAP_SETTINGS))),
  setting = c(SCOPE_SETTINGS$setting,
              vapply(G_SETTINGS, function(s) paste0(s$setting, ", N = ", s$N, ", ", s$generating), ""),
              vapply(LAP_SETTINGS, function(s) paste(s$setting, s$generating), "")),
  expected = c(SCOPE_SETTINGS$reps, vapply(G_SETTINGS, function(s) as.numeric(s$reps), 0),
               rep(opt$reps_laplace, length(LAP_SETTINGS))),
  got = c(vapply(SCOPE_SETTINGS$setting, function(s) as.numeric(n_got(scope_raw, s)), 0),
          vapply(G_SETTINGS, function(s) as.numeric(length(unique(
            g_raw$rep[g_raw$setting == s$setting & g_raw$N == s$N & g_raw$generating == s$generating]))), 0),
          vapply(LAP_SETTINGS, function(s) as.numeric(n_got(lap_raw, s$setting, s$generating)), 0)),
  stringsAsFactors = FALSE)
dropped$dropped <- dropped$expected - dropped$got
n_dropped <- sum(dropped$dropped)

# ---------------------------------------------------------------- search run (--only)

# One row per family, setting and generating account (scope) or intraclass correlation (G), with
# the columns smallest_sample.py reads: own_rate is the generating account's support rate (scope)
# or the gate's pass rate at .30 against .15 (G); max_rival_rate is the highest support rate of any
# other rival (scope) or the gate's false-pass rate at .15 against .15 (G). Then stop.
if (!is.null(ONLY)) {
  srch_scope <- do.call(rbind, lapply(split(scope_raw, list(scope_raw$setting, scope_raw$generating),
                                            drop = TRUE), function(x) {
    g <- x$generating[1]
    sup <- support_rates(x[c("S1", "S2")], SCOPE_ACCOUNTS)
    data.frame(study = "A1", family = "scope", setting = x$setting[1],
               N = SCOPE_SETTINGS$N[SCOPE_SETTINGS$setting == x$setting[1]], generating = g,
               n_datasets = nrow(x), own_rate = sup[[g]],
               max_rival_rate = max(c(0, sup[setdiff(RIVALS, g)])), rival_datasets = NA,
               mean_est = NA, mean_se = NA,
               conv_any = mean(x$conv_removed > 0, na.rm = TRUE),
               fit_failed = mean(is.na(x$removed)), stringsAsFactors = FALSE)
  }))
  plan <- Filter(function(s) s$kind == "planning", G_SETTINGS)
  srch_g <- do.call(rbind, lapply(Filter(function(s) s$p_ai == 0.30, plan), function(s) {
    s0 <- Filter(function(z) z$setting == s$setting && z$icc == s$icc && z$p_ai == 0.15, plan)[[1]]
    x <- g_raw[g_raw$setting == s$setting & g_raw$generating == s$generating, ]
    x0 <- g_raw[g_raw$setting == s0$setting & g_raw$generating == s0$generating, ]
    data.frame(study = "A1", family = "G", setting = s$setting, N = s$N, generating = s$generating,
               n_datasets = nrow(x), own_rate = mean(g_pass(x$G_est, x$G_se)),
               max_rival_rate = mean(g_pass(x0$G_est, x0$G_se)), rival_datasets = nrow(x0),
               mean_est = mean(x$G_est, na.rm = TRUE), mean_se = mean(x$G_se, na.rm = TRUE),
               conv_any = mean(c(x$G_conv_removed, x0$G_conv_removed) > 0, na.rm = TRUE),
               fit_failed = mean(is.na(c(x$G_removed, x0$G_removed))), stringsAsFactors = FALSE)
  }))
  srch <- rbind(srch_scope, srch_g)
  srch <- srch[order(srch$family != "scope", srch$setting, srch$generating), ]
  srch$mode <- if (isTRUE(opt$quick)) "quick" else "full"
  out_csv <- file.path(out_dir, paste0("A1_sim", TAG, ".csv"))
  write.csv(srch, out_csv, row.names = FALSE)
  print(srch[c("family", "setting", "N", "generating", "n_datasets", "own_rate", "max_rival_rate")],
        row.names = FALSE)
  cat(sprintf("Wrote results/%s (search run: no report). Elapsed %.1f minutes.\n", basename(out_csv),
              as.numeric(difftime(Sys.time(), started, units = "mins"))))
  if (n_dropped > 0) {
    print(dropped[dropped$dropped > 0, ], row.names = FALSE)
    stop(sprintf("%d datasets dropped", n_dropped))
  }
  quit(save = "no")
}

# ---------------------------------------------------------------- summaries

# Share of fits whose accepted model had k random terms removed (k = 0 is the registered model), that
# kept each slope and the scene intercept, the share of all removals that followed a convergence
# failure that was not also a singular fit, and the share with no usable fit.
fb_shares <- function(x, slopes, pre = "", sfx = "") {
  col <- function(n) x[[paste0(pre, n, sfx)]]
  removed <- col("removed")
  out <- sapply(0:(length(slopes) + 1), function(k) mean(removed %in% k))
  names(out) <- paste0("removed_", 0:(length(slopes) + 1))
  keep <- sapply(term_id(slopes), function(t) mean(col(paste0("keep_", t)), na.rm = TRUE))
  names(keep) <- paste0("kept_", term_id(slopes))
  tot <- sum(removed, na.rm = TRUE)
  c(out, keep, kept_scene_intercept = mean(col("scene_int"), na.rm = TRUE),
    removals_after_convergence_failure = if (tot > 0) sum(col("conv_removed"), na.rm = TRUE) / tot
                                         else NA,
    accepted_with_gradient_warning = if (is.null(col("grad_warn"))) NA
                                     else mean(col("grad_warn"), na.rm = TRUE),
    fit_failed = mean(is.na(removed)))
}

state_shares <- function(x, name) {
  st <- c("zero", "positive", "negative", "undetermined")
  setNames(sapply(st, function(s) mean(x == s)), paste0(name, "_", st))
}

KEYS <- sapply(SCOPE_ACCOUNTS, `[[`, "key")
scope_tab <- do.call(rbind, lapply(split(scope_raw, list(scope_raw$setting, scope_raw$generating),
                                         drop = TRUE), function(x) {
  s <- SCOPE_SETTINGS[SCOPE_SETTINGS$setting == x$setting[1], ]
  g <- x$generating[1]
  sup <- support_rates(x[c("S1", "S2")], SCOPE_ACCOUNTS)
  is_acc <- g %in% names(SCOPE_ACCOUNTS)
  data.frame(
    family = "scope", setting = s$setting, N = s$N, generating = g, n_datasets = nrow(x),
    mult = if (is_acc) s$mult else NA, sic = s$sic, sd_ps = s$sd_ps, sd_item = s$sd_item,
    own_rate = if (is_acc) sup[[g]] else NA,
    max_rival = if (is_acc) max(c(0, sup[setdiff(RIVALS, g)])) else NA,
    t(setNames(sup, paste0("support_", KEYS))),
    S1_true = x$S1_true[1], t(state_shares(x$S1, "S1")),
    S1_mean_est = mean(x$S1_est, na.rm = TRUE), S1_mean_se = mean(x$S1_se, na.rm = TRUE),
    S2_true = x$S2_true[1], t(state_shares(x$S2, "S2")),
    S2_mean_est = mean(x$S2_est, na.rm = TRUE), S2_mean_se = mean(x$S2_se, na.rm = TRUE),
    t(fb_shares(x, SCOPE_SLOPES)),
    sec_per_fit = mean(x$sec), stringsAsFactors = FALSE, check.names = FALSE)
}))
scope_tab <- scope_tab[order(match(scope_tab$setting, SCOPE_SETTINGS$setting),
                             match(scope_tab$generating, c(names(SCOPE_ACCOUNTS), names(RESIDUE)))), ]

g_summary <- function(x, sfx = "") {
  col <- function(n) x[[paste0(n, sfx)]]
  c(G_pass = mean(g_pass(col("G_est"), col("G_se"))),
    IC_usable = mean(ic_pass(col("IC_est"), col("IC_se"))),
    ICf_usable = mean(ic_pass(col("ICf_est"), col("ICf_se"))),
    G_mean_est = mean(col("G_est"), na.rm = TRUE), G_mean_se = mean(col("G_se"), na.rm = TRUE),
    IC_mean_est = mean(col("IC_est"), na.rm = TRUE),
    IC_mean_upper = mean(col("IC_est") + qnorm(0.975) * col("IC_se"), na.rm = TRUE),
    ICf_mean_est = mean(col("ICf_est"), na.rm = TRUE),
    ICf_mean_upper = mean(col("ICf_est") + qnorm(0.975) * col("ICf_se"), na.rm = TRUE))
}
g_rows <- function(s, x, nagq, sfx = "") {
  data.frame(family = switch(s$kind, planning = "G (planning scenario)",
                             pattern = "G (specification pattern)", bound = "G (at the bound)"),
             setting = s$setting, N = s$N, generating = s$generating, nAGQ = nagq,
             n_datasets = nrow(x), true_G = s$true_G, true_IC = s$true_IC, sic = s$sic,
             sd_participant = s$sd_p, sd_participant_by_amount = s$sd_pa,
             sd_participant_by_source = s$sd_ps, sd_participant_by_block = s$sd_pb,
             sd_scene = s$sd_s, t(g_summary(x, sfx)),
             stringsAsFactors = FALSE, check.names = FALSE)
}
pick <- function(raw, s) raw[raw$setting == s$setting & raw$N == s$N & raw$generating == s$generating, ]

# The fit records of both instrument-check fits of each dataset (own values, failing value) stacked,
# with the prefix taken off, so that fb_shares() can pool them.
IC_POOL <- function(raw, sfx = "") {
  pull <- function(pre) {
    cols <- grep(paste0("^", pre, "_(removed|conv_removed|scene_int|grad_warn|keep_)"), names(raw), value = TRUE)
    cols <- cols[if (sfx == "") !grepl("_laplace$", cols) else endsWith(cols, sfx)]
    x <- raw[cols]
    names(x) <- sub(paste0("^", pre, "_"), "", sub(paste0(sfx, "$"), "", cols))
    x
  }
  rbind(pull("IC"), pull("ICf"))
}
ic_diag <- function(x) {
  sh <- fb_shares(IC_POOL(x), RULE_SLOPES)
  setNames(sh, paste0("IC_", names(sh)))
}
g_tab <- do.call(rbind, lapply(G_SETTINGS, function(s) {
  x <- pick(g_raw, s)
  cbind(g_rows(s, x, 0), t(fb_shares(x, G_SLOPES, "G_")), t(ic_diag(x)),
        sec_per_dataset = mean(x$sec))
}))
# Laplace rows beside the nAGQ = 0 rows of the same datasets (main run, same seeds); G columns are
# left empty where G was not refitted with Laplace.
G_COLS <- c("G_pass", "G_mean_est", "G_mean_se")
IC_COLS <- c("IC_usable", "ICf_usable", "IC_mean_est", "IC_mean_upper", "ICf_mean_est", "ICf_mean_upper")
lap_tab <- do.call(rbind, lapply(LAP_SETTINGS, function(s) {
  x1 <- pick(lap_raw, s)
  x0 <- pick(g_raw, s)
  x0 <- x0[x0$rep %in% x1$rep, ]
  r0 <- cbind(g_rows(s, x0, 0), sec_per_dataset = NA)
  r1 <- cbind(g_rows(s, x1, 1, "_laplace"), sec_per_dataset = mean(x1$sec))
  if (!s$laplace_g) r0[G_COLS] <- r1[G_COLS] <- NA
  if (!s$laplace_ic) r0[IC_COLS] <- r1[IC_COLS] <- NA
  rbind(r0, r1)
}))
lap_tab$family <- "G and instrument check (Laplace check)"

# Bind tables with different columns, filling the missing ones with NA.
bind_fill <- function(dfs) {
  cols <- unique(unlist(lapply(dfs, names)))
  do.call(rbind, lapply(dfs, function(d) {
    d[setdiff(cols, names(d))] <- NA
    d[cols]
  }))
}
full_tab <- bind_fill(list(scope_tab, g_tab, lap_tab))
full_tab$run <- if (isTRUE(opt$quick)) "quick" else "full"
write.csv(full_tab, file.path(out_dir, paste0("A1_sim", TAG, ".csv")), row.names = FALSE)

# ---------------------------------------------------------------- criteria

yn <- function(x) ifelse(x, "yes", "no")
acc_tab <- scope_tab[scope_tab$generating %in% names(SCOPE_ACCOUNTS), ]
rate <- function(setting) acc_tab$own_rate[acc_tab$setting == setting]
rival_in <- function(settings) max(acc_tab$max_rival[acc_tab$setting %in% settings])
crit <- do.call(rbind, lapply(list(c("main0", "main1"), c("fall0", "fall1")), function(m) {
  lo0 <- min(rate(m[1]))
  lo1 <- min(rate(m[2]))
  rv <- rival_in(m)
  data.frame(Sample = sprintf("%s (N = %d; %s, %s)", if (m[1] == "main0") "Target" else "Fallback",
                              SCOPE_SETTINGS$N[SCOPE_SETTINGS$setting == m[1]], m[1], m[2]),
             `Lowest generating rate, scene-by-source SD 0` = lo0,
             `Lowest generating rate, scene-by-source SD 0.10` = lo1,
             `Highest rival rate` = rv,
             `(a) at least .80 and .70` = yn(lo0 >= 0.80 & lo1 >= 0.70),
             `(b) every rival at most .05` = yn(rv <= 0.05), check.names = FALSE)
}))

# Gate G and the instrument check: 1.10's thresholds applied to the gate's pass rate and the
# check's verdict (the design record states them for account families; 3.3 reports G against them).
gt <- g_tab
grate <- function(kind, settings, gens, N, what = "G_pass") {
  gt[[what]][gt$family == kind & gt$setting %in% settings & gt$generating %in% gens & gt$N == N]
}
plan_g <- function(p, icc = c(0.25, 0.50)) plan_label(p, icc)
NT <- DESIGNS$target$n
NF <- DESIGNS$fallback$n
gcrit_row <- function(check, thr, at_least, target, fallback) {
  data.frame(Check = check, Threshold = sprintf("%s %s", if (at_least) "at least" else "at most",
                                                 sub("^0", "", sprintf("%.2f", thr))),
             Target = target, Fallback = fallback,
             `Met at target` = yn(if (at_least) target >= thr else target <= thr),
             `Met at fallback` = yn(if (at_least) fallback >= thr else fallback <= thr),
             check.names = FALSE)
}
GP <- "G (planning scenario)"
GS <- "G (specification pattern)"
ic_ok <- names(DECISION_PATTERNS)[sapply(DECISION_PATTERNS, function(p) p[2, 2, 4] >= 1 / 3)]
ic_bad <- setdiff(names(DECISION_PATTERNS), ic_ok)
gcrit <- rbind(
  gcrit_row("G passes, planning .30 vs .15, ICC .25, scene-by-source SD 0", 0.80, TRUE,
            grate(GP, "main0", plan_g(.30, .25), NT), grate(GP, "fall0", plan_g(.30, .25), NF)),
  gcrit_row("G passes, planning .30 vs .15, ICC .50, scene-by-source SD 0", 0.80, TRUE,
            grate(GP, "main0", plan_g(.30, .50), NT), grate(GP, "fall0", plan_g(.30, .50), NF)),
  gcrit_row("G passes, planning .30 vs .15, scene-by-source SD 0.3, lower of the two ICCs", 0.70, TRUE,
            min(grate(GP, "main1", plan_g(.30), NT)), min(grate(GP, "fall1", plan_g(.30), NF))),
  gcrit_row("G passes, planning .40 vs .15, scene-by-source SD 0, lower of the two ICCs", 0.80, TRUE,
            min(grate(GP, "main0", plan_g(.40), NT)), min(grate(GP, "fall0", plan_g(.40), NF))),
  gcrit_row("G passes falsely, planning .15 vs .15, highest over both ICCs and scene-by-source SDs",
            0.05, FALSE, max(grate(GP, c("main0", "main1"), plan_g(.15), NT)),
            max(grate(GP, c("fall0", "fall1"), plan_g(.15), NF))),
  gcrit_row("G passes, patterns with true G 0.50 (Office, scoped credit), scene-by-source SD 0: lowest",
            0.80, TRUE, min(grate(GS, "main0", G_TRUE_PATTERNS, NT)),
            min(grate(GS, "fall0", G_TRUE_PATTERNS, NF))),
  gcrit_row("G passes, patterns with true G 0.50, scene-by-source SD 0.3: lowest", 0.70, TRUE,
            min(grate(GS, "main1", G_TRUE_PATTERNS, NT)),
            min(grate(GS, "fall1", G_TRUE_PATTERNS, NF))),
  gcrit_row("G passes falsely, patterns with true G 0 (area, taint, provenance ignored): highest",
            0.05, FALSE, max(grate(GS, c("main0", "main1"), G_NULL_PATTERNS, NT)),
            max(grate(GS, c("fall0", "fall1"), G_NULL_PATTERNS, NF))),
  gcrit_row(sprintf("Instrument check finds the option usable, true value at least 1/3 (%s): lowest",
                    paste(ic_ok, collapse = ", ")), 0.80, TRUE,
            min(grate(GS, c("main0", "main1"), ic_ok, NT, "IC_usable")),
            min(grate(GS, c("fall0", "fall1"), ic_ok, NF, "IC_usable"))),
  gcrit_row(sprintf("Instrument check finds the option usable, true value below 1/3 (%s; and %.2f under every pattern): highest",
                    paste(ic_bad, collapse = ", "), IC_FAIL), 0.05, FALSE,
            max(c(grate(GS, c("main0", "main1"), ic_bad, NT, "IC_usable"),
                  grate(GS, c("main0", "main1"), names(DECISION_PATTERNS), NT, "ICf_usable"))),
            max(c(grate(GS, c("fall0", "fall1"), ic_bad, NF, "IC_usable"),
                  grate(GS, c("fall0", "fall1"), names(DECISION_PATTERNS), NF, "ICf_usable")))))

# ---------------------------------------------------------------- report helpers

fmt <- function(x, digits = 2, whole = FALSE) {
  if (!is.numeric(x)) return(gsub("|", "\\|", as.character(x), fixed = TRUE))
  ifelse(is.na(x), "", if (whole) formatC(x, format = "d", big.mark = ",")
         else formatC(x, format = "f", digits = digits))
}
md_table <- function(df, digits = 2, whole = c("n_datasets", "Datasets", "nAGQ", "N")) {
  cells <- sapply(names(df), function(n) fmt(df[[n]], digits, n %in% whole))
  if (is.null(dim(cells))) cells <- matrix(cells, nrow = 1)
  c(paste0("| ", paste(names(df), collapse = " | "), " |"),
    paste0("|", paste(rep("---", ncol(df)), collapse = "|"), "|"),
    apply(cells, 1, function(r) paste0("| ", paste(r, collapse = " | "), " |")))
}
wide <- function(df, value, rows = "generating", label = "Generating account") {
  w <- reshape(df[c(rows, "setting", value)], idvar = rows, timevar = "setting", direction = "wide")
  names(w) <- sub(paste0("^", value, "\\."), "", names(w))
  names(w)[1] <- label
  w
}

# ---------------------------------------------------------------- report tables

own <- wide(acc_tab, "own_rate")
rv <- wide(acc_tab, "max_rival")
res_tab <- scope_tab[scope_tab$generating %in% names(RESIDUE),
                     c("setting", "N", "generating", "n_datasets", "S2_zero", "S2_positive",
                       "S2_undetermined", "support_scoped_credit", "support_taint")]

pat_tab <- g_tab[g_tab$family == GS, ]
g_own <- wide(pat_tab, "G_pass", label = "Decision pattern")
ic_own <- wide(pat_tab, "IC_usable", label = "Decision pattern")
icf_own <- wide(pat_tab, "ICf_usable", label = "Decision pattern")
bound_tab <- g_tab[g_tab$family == "G (at the bound)",
                   c("setting", "N", "generating", "n_datasets", "true_G", "G_pass", "G_mean_est",
                     "G_mean_se")]
gp <- g_tab[g_tab$family == GP, c("setting", "N", "generating", "n_datasets", "true_G", "G_pass",
                                  "G_mean_est", "G_mean_se")]
gs <- pat_tab[c("setting", "N", "generating", "n_datasets", "true_G", "G_pass", "G_mean_est",
                "G_mean_se", "true_IC", "IC_usable", "IC_mean_est", "IC_mean_upper", "ICf_usable",
                "ICf_mean_upper")]
lt <- lap_tab[c("setting", "generating", "nAGQ", "n_datasets", "G_pass", "G_mean_est", "G_mean_se",
                "IC_usable", "IC_mean_upper", "ICf_usable", "ICf_mean_upper")]
lap_pair <- merge(g_raw[c("setting", "N", "generating", "rep", "G_est", "IC_est")],
                  lap_raw[c("setting", "N", "generating", "rep", "G_est_laplace", "IC_est_laplace")])
lap_shift <- sapply(split(lap_pair, lap_pair$generating), function(x) {
  c(G = mean(x$G_est - x$G_est_laplace, na.rm = TRUE),
    IC = mean(x$IC_est - x$IC_est_laplace, na.rm = TRUE))
})
LAP_G_GENS <- sapply(Filter(function(s) s$laplace_g, LAP_SETTINGS), `[[`, "generating")
LAP_IC_GENS <- sapply(Filter(function(s) s$laplace_ic, LAP_SETTINGS), `[[`, "generating")

# Fit diagnostics pooled over the settings of each family.
diag_scope <- fb_shares(scope_raw, SCOPE_SLOPES)
diag_g <- fb_shares(g_raw, G_SLOPES, "G_")
diag_ic <- fb_shares(IC_POOL(g_raw), RULE_SLOPES)
lap_raw_g <- lap_raw[lap_raw$generating %in% LAP_G_GENS, ]
diag_gl <- fb_shares(lap_raw_g, G_SLOPES, "G_", "_laplace")
lap_raw_ic <- lap_raw[lap_raw$generating %in% LAP_IC_GENS, ]
diag_icl <- fb_shares(IC_POOL(lap_raw_ic, "_laplace"), RULE_SLOPES)
diag_md <- function(label, sh, n) {
  c(sprintf("%s (%s fits):", label, format(n, big.mark = ",")), "",
    md_table(data.frame(t(sh), check.names = FALSE)), "")
}

# Seconds per fit or dataset, and the full run at the default numbers of datasets on 11 cores
# (per-setting mean time x default count, summed).
def_n <- function(kind) DEFAULT_REPS[[kind]]
sec_scope_set <- sapply(SCOPE_SETTINGS$setting, function(s) mean(scope_raw$sec[scope_raw$setting == s]))
fits_scope_set <- sapply(seq_len(nrow(SCOPE_SETTINGS)), function(i) {
  n <- def_n(SCOPE_SETTINGS$reps_kind[i])
  n * length(SCOPE_ACCOUNTS) + if (SCOPE_SETTINGS$residue[i]) min(n, def_n("reps_small")) * length(RESIDUE) else 0
})
sec_g_set <- sapply(G_SETTINGS, function(s) mean(pick(g_raw, s)$sec))
n_g_set <- sapply(G_SETTINGS, function(s) def_n(s$reps_kind))
sec_lap_set <- sapply(LAP_SETTINGS, function(s) mean(pick(lap_raw, s)$sec))
full_sec <- c(scope = sum(sec_scope_set * fits_scope_set),
              G = sum(sec_g_set * n_g_set),
              laplace = sum(sec_lap_set * def_n("reps_laplace")))
full_min <- sum(full_sec) / 11 / 60
sec_scope <- mean(scope_raw$sec)
sec_g <- mean(g_raw$sec)
sec_g_fit <- mean(g_raw$sec_G)
sec_ic_fit <- mean(g_raw$sec_IC) / 2
sec_lap_g <- mean(lap_raw$sec_G_laplace[lap_raw$generating %in% LAP_G_GENS])
sec_lap_ic <- mean(lap_raw$sec_IC_laplace[lap_raw$generating %in% LAP_IC_GENS]) / 2
lap_g_bare <- mean(lap_raw_g$G_removed_laplace == length(G_SLOPES) + 1, na.rm = TRUE)

si <- sessionInfo()
pkg_line <- function(p) paste(sapply(p, function(x) paste(x$Package, x$Version)), collapse = ", ")
script_path <- file.path(script_dir(), "sim_A1.R")

settings_md <- data.frame(
  Setting = SCOPE_SETTINGS$setting, N = SCOPE_SETTINGS$N,
  `Nonzero contrasts` = ifelse(SCOPE_SETTINGS$mult == 1.5, "1.5 x bound (0.336)", "at the bound (0.224)"),
  `Scene-by-source SD` = SCOPE_SETTINGS$sic,
  `Participant-by-source SD` = round(SCOPE_SETTINGS$sd_ps, 3),
  `Participant-by-item SD` = round(SCOPE_SETTINGS$sd_item, 3),
  Datasets = SCOPE_SETTINGS$reps, check.names = FALSE)
g_settings_md <- do.call(rbind, lapply(G_SETTINGS, function(s) data.frame(
  Setting = s$setting, N = s$N, Generating = s$generating, `True G` = s$true_G,
  `True P(divided, AI, block 2)` = s$true_IC, `Participant SD` = round(s$sd_p, 3),
  `Participant-by-amount SD` = round(s$sd_pa, 3), `Participant-by-source SD` = round(s$sd_ps, 3),
  `Participant-by-block SD` = round(s$sd_pb, 3),
  `Scene SD` = s$sd_s, `Scene-by-source SD` = s$sic, Datasets = s$reps,
  `Laplace check` = if (!s$laplace) "no" else if (s$laplace_g && s$laplace_ic) "G and instrument check"
                    else if (s$laplace_g) "G" else "instrument check", check.names = FALSE)))

# The ten lists: the scene in each slot, with the slot's cell in the header.
cell_name <- function(i) {
  sl <- SLOTS[i, ]
  sprintf("%s %s%s", if (sl$src > 0) "hand-made" else "AI",
          c("none", "small", "medium", "large")[sl$amount + 1],
          if (sl$block == 2) " (block 2)" else "")
}
one <- DESIGNS$target$all[!duplicated(DESIGNS$target$all[c("list", "slot")]), ]
list_md <- reshape(transform(one, scene = sprintf("SA%02d", scene))[c("list", "slot", "scene")],
                   idvar = "list", timevar = "slot", direction = "wide")
names(list_md) <- c("List", sapply(seq_len(nrow(SLOTS)), function(i) sprintf("Slot %d: %s", i - 1, cell_name(i))))
list_md$List <- as.character(list_md$List)

shown <- c("setting", "N", "generating", "n_datasets", "own_rate", "max_rival",
           paste0("support_", KEYS),
           "S1_true", "S1_zero", "S1_positive", "S1_negative", "S1_undetermined",
           "S1_mean_est", "S1_mean_se", "S2_true", "S2_zero", "S2_positive", "S2_negative",
           "S2_undetermined", "S2_mean_est", "S2_mean_se", "sec_per_fit")
scope_diag_cols <- c("setting", "N", "generating", grep("^removed_|^kept_|^removals_|^accepted_|^fit_failed",
                                                         names(scope_tab), value = TRUE))
g_shown <- c("family", "setting", "N", "generating", "nAGQ", "n_datasets", "true_G", "G_pass",
             "G_mean_est", "G_mean_se", "true_IC", "IC_usable", "IC_mean_est", "IC_mean_upper",
             "ICf_usable", "ICf_mean_est", "ICf_mean_upper", "sec_per_dataset")
g_diag_cols <- c("setting", "N", "generating",
                 grep("^(removed_|kept_|removals_|accepted_|fit_failed)", names(g_tab), value = TRUE))
ic_diag_cols <- c("setting", "N", "generating", grep("^IC_(removed_|kept_|removals_|accepted_|fit_failed)",
                                                     names(g_tab), value = TRUE))

report <- c(
  "# Study A1: sample-size simulation (within-subjects design)",
  "",
  sprintf("Run date %s. Datasets: %d per main setting and planning scenario at the target, %d per bound, sensitivity and fallback setting, %d for the Laplace check. Cores: %d. Datasets dropped: %d.%s",
          run_date, opt$reps, opt$reps_small, opt$reps_laplace, opt$cores, n_dropped,
          if (isTRUE(opt$quick)) " **Quick run (--quick): too few datasets for any conclusion; it checks that the code runs.**" else ""),
  "",
  "## Criteria",
  "",
  "Scope family (S1, S2). Criteria of 1.10: (a) the generating account is supported in at least .80 of datasets with no scene-by-source variation and at least .70 with 0.10 SD; (b) every rival is supported in at most .05. All three accounts are rivals; none is compatible.",
  "",
  md_table(crit),
  "",
  "Gate G and the instrument check. The thresholds are 1.10's, applied to the pass rate of the gate and to the verdict of the check. \"True value\" for the instrument check is P(divided | AI, large, rule stated) in block 2; the check should find the divided option usable when it is at least 1/3 and not usable when it is below.",
  "",
  md_table(gcrit),
  "",
  "## Each generating account's own rate in every setting",
  "",
  "Scope family, share of datasets in which the generating account is supported:",
  "",
  md_table(own),
  "",
  "Scope family, highest support rate of any other rival account:",
  "",
  md_table(rv),
  "",
  "Gate G, share of datasets in which G passes, by decision pattern (true G 0.50 under Office and scoped credit, 0 under the others):",
  "",
  md_table(g_own),
  "",
  "Instrument check, share of datasets in which it finds the divided option usable, under each pattern's own block-2 value (Office 0.75, area and scoped credit 0.60, taint and provenance ignored 0.10):",
  "",
  md_table(ic_own),
  "",
  sprintf("Instrument check, the same with P(divided | AI, large, rule stated) set to the failing value %.2f (same datasets otherwise):", IC_FAIL),
  "",
  md_table(icf_own),
  "",
  sprintf("Mean estimate of P(divided | AI, large, rule stated) by the instrument-check model (nAGQ = 0), over the pattern settings: %s with the failing value %.2f; %s at a true 0.75 (Office); %s at a true 0.10 (taint, provenance ignored).",
          fmt(mean(pat_tab$ICf_mean_est), 3), IC_FAIL,
          fmt(mean(pat_tab$IC_mean_est[pat_tab$generating == "Office"]), 3),
          fmt(mean(pat_tab$IC_mean_est[pat_tab$generating %in% c("Taint", "Provenance ignored")]), 3)),
  "",
  "Gate G at the bound (true G 0.10, the probability bound, where a pass is close to chance):",
  "",
  md_table(bound_tab),
  "",
  "Gate G under the planning scenarios of the registration's Rationale (participant SD from the intraclass correlation; every other component as in the main settings: participant-by-amount, participant-by-source and participant-by-block SD 0.5, scene SD 0.4, scene-by-source SD 0 in main0 and fall0, 0.3 in main1 and fall1; cells other than the two large block-1 cells take the Office's values; .40 against .15 runs only without scene-by-source variation). The .30 and .15 rows at main0 and main1 are the gate's rows in the smallest-sample search:",
  "",
  md_table(gp),
  "",
  "S2 at Paper One's residue (S1 at 1.5 x bound), first datasets of main0 and main1:",
  "",
  md_table(res_tab),
  "",
  "## Settings",
  "",
  "Scope family (all three accounts generate data in every setting; SDs on the 1-to-5 scale):",
  "",
  md_table(settings_md, digits = 3),
  "",
  "Gate G and the instrument check (SDs on the log-odds scale):",
  "",
  md_table(g_settings_md, digits = 3),
  "",
  "## Design",
  "",
  sprintf("- Samples: target %d analyzable (%d per list), fallback %d (%d per list). Every participant sees all ten Set A scenes once, one condition per scene. Block 1 (no rule stated): eight trials, source (AI, hand-made) x amount (none, small, medium, large), one trial per cell. Block 2 (after the rule paragraph and its recall items): two trials, AI large and hand-made large. Trial order within a block does not enter the generating model.",
          DESIGNS$target$n, DESIGNS$target$n / N_LIST, DESIGNS$fallback$n, DESIGNS$fallback$n / N_LIST),
  "- Lists (12.3 and the registration's Randomization paragraph): scenes in the interleaved order SA01, SA06, SA02, SA07, SA03, SA08, SA04, SA09, SA05, SA10; list k puts the scene at position (j + k) modulo 10 in slot j. Slots 0 and 1 carry no change, 2 and 3 the small addition, 4 and 5 the medium, 6 and 7 the large; the AI story takes slots 0, 2, 5 and 7 and the hand-made story slots 1, 3, 4 and 6; slot 8 (AI) and slot 9 (hand-made) are block 2, both large. Within each list each source in block 1 falls on two scenes with a person and two without, each amount on one of each, and so do the written-reason trials (slots 2 and 7), the stop-others trials (6 and 7) and block 2. Across the ten lists every scene appears in every slot once. The script checks these properties before it runs.",
  "- Participants cycle through the ten lists; the order of the two creativity items alternates within each list.",
  "",
  md_table(list_md),
  "",
  "## Models and codes",
  "",
  "- Codes: source hand-made +0.5, AI -0.5; item whole image +0.5, addition -0.5; item order whole first -0.5, addition first +0.5; amount by orthonormal polynomial contrasts (am1 to am3 over none to large for the decision, am1 and am2 over small to large for creativity).",
  sprintf("- Scope family: linear mixed model (lmerTest, REML) on the two creativity items stacked over the six block-1 change trials; S1 and S2 by the state rule with Satterthwaite df and bound %.3f. Label effect = hand-made minus AI, averaged over amounts; S2 = label effect on the addition item, S1 = label effect on the whole-image item minus S2. First model tried: `%s`.",
          B_CRE, first_formula(SCOPE_FIXED, SCOPE_SLOPES)),
  sprintf("- Gate G: logistic mixed model (glmer, nAGQ = 0 in the main runs; nAGQ = 1, the registered Laplace fit, in the Laplace check below) on divided (1) against either other option (0) over the eight block-1 trials. G = population-averaged P(divided | AI, large) minus P(divided | hand-made, large), probabilities averaged over the fitted random effects, delta-method standard error; passes if one-sided p < .05 and estimate at least %.2f. First model tried: `%s`.",
          B_PROB, first_formula(G_FIXED, G_SLOPES)),
  sprintf("- Instrument check: the registration's rule model, a logistic mixed model on the four large-addition trials, two in each block (block coded -0.5 for block 1 and +0.5 for block 2), with a participant intercept only and by-scene slopes for source and block; population-averaged P(divided | AI, large, block 2) with a delta-method 95 percent interval; the divided option is not usable if the upper end is below 1/3. First model tried: `%s`.",
          first_formula(RULE_FIXED, RULE_SLOPES)),
  "",
  "## Removal rule and convergence",
  "",
  "Every model is fitted by fit_registered() in sim_common.R (1.8 revised). The linear model uses lme4's default settings. The logistic models use lme4's defaults except the optimizer, bobyqa in both stages of glmer in place of the default second stage, Nelder-Mead (results/A1_convergence_note.md). A fit fails when it stops with an error, fails to converge (the optimizer returns a nonzero code, or lme4 or lmerTest warns that the model failed to converge; for the logistic models also when a random-effect SD exceeds 10 on the log-odds scale, a variance running off toward infinity) or is singular. After a failed fit one random term is removed and the model refitted: interaction slopes first (none are registered here), then the slope with the smallest estimated variance in the failed fit, then the scene intercept. The model left after the last removal is accepted as it is. Slopes are listed smallest generating variance first, scene before participant; the order breaks ties and chooses the slope to remove when a fit stops with an error:",
  "",
  sprintf("- scope: %s", paste(SCOPE_SLOPES, collapse = ", ")),
  sprintf("- G: %s", paste(G_SLOPES, collapse = ", ")),
  sprintf("- instrument check: %s", paste(RULE_SLOPES, collapse = ", ")),
  "",
  "## Fit diagnostics",
  "",
  "removed_k: share of fits whose accepted model had k random terms removed (0 = the first model); kept_*: share keeping that term; removals_after_convergence_failure: share of all removals that followed a convergence failure that was not also a singular fit (the rest followed a singular fit or an error); fit_failed: share with no usable fit. Pooled over all settings of each family:",
  "",
  diag_md("Scope family", diag_scope, nrow(scope_raw)),
  diag_md("Gate G, nAGQ = 0", diag_g, nrow(g_raw)),
  diag_md("Instrument check, nAGQ = 0 (own values and failing value)", diag_ic, 2 * nrow(g_raw)),
  diag_md(sprintf("Gate G, Laplace (%s)", paste(LAP_G_GENS, collapse = ", ")), diag_gl, nrow(lap_raw_g)),
  diag_md("Instrument check, Laplace", diag_icl, 2 * nrow(lap_raw_ic)),
  "By setting, scope family:",
  "",
  md_table(scope_tab[scope_tab$generating %in% names(SCOPE_ACCOUNTS), scope_diag_cols]),
  "",
  "By setting, gate G:",
  "",
  md_table(g_tab[g_diag_cols]),
  "",
  "By setting, instrument check (own values and failing value pooled):",
  "",
  md_table(g_tab[ic_diag_cols]),
  "",
  "## Full results",
  "",
  "Scope family:",
  "",
  md_table(scope_tab[shown]),
  "",
  "Gate G and the instrument check (IC: under the setting's own block-2 values; ICf: with the failing value):",
  "",
  md_table(full_tab[full_tab$family != "scope", g_shown]),
  "",
  "## Laplace check",
  "",
  sprintf("The first %d datasets of each main0 decision pattern and of the main0 planning scenarios at .30 and .15 against .15, refitted with nAGQ = 1 (Laplace, the registered fitting method) and set beside the nAGQ = 0 fits of the same datasets: G under every pattern and planning scenario, the instrument check under every pattern. Fitting settings and convergence rule as above; %s of the Laplace fits of G ended with the participant intercept alone, and %s of the accepted Laplace fits of G carried lme4's gradient warning.",
          opt$reps_laplace, fmt(lap_g_bare), fmt(diag_gl[["accepted_with_gradient_warning"]])),
  "",
  md_table(lt),
  "",
  sprintf("Mean difference, nAGQ = 0 minus Laplace estimate, on the same datasets: G %s; instrument check %s.",
          paste(sprintf("%s at %s", fmt(lap_shift["G", LAP_G_GENS], 3), LAP_G_GENS), collapse = "; "),
          paste(sprintf("%s at %s", fmt(lap_shift["IC", LAP_IC_GENS], 3), LAP_IC_GENS), collapse = "; ")),
  "",
  "## Generating model",
  "",
  "- Creativity (1.10 and plan_sim_v2.py): participant SD 0.62; participant-by-source SD 0.25 (12.1.8), shared by the two items; participant-by-item SD 0.25 added to the addition item only; scene SD 0.2; residual SD 0.7; scene-by-source deviations of SD 0 or 0.10, shared by the two items. No effects of amount or item order. Ratings are generated as normal and not rounded or clipped to 1-5, as in the planning simulation.",
  "- Scope accounts: a contrast the account calls nonzero is set to 1.5 x bound (or the bound), else 0 (scoped credit S1 > 0, S2 = 0; taint S1 = 0, S2 > 0; provenance ignored both 0). The same noise is used for every account within a dataset.",
  "- Decision: P(divided) per cell is population-averaged; the linear predictor is solved so that averaging over all random effects gives it. Random effects: participant (SD 1.5, or from the intraclass correlation in the planning scenarios), participant-by-amount, participant-by-source and participant-by-block (independent deviations for each level, SD 0.5 each, 12.1.8), scene (SD 0.4) and scene-by-source (SD 0 or 0.3); block 2 carries the same participant, source and scene effects as block 1. Block 2 is drawn twice from the same random effects and uniform draws, once with the setting's own rule-stated values and once with P(divided | AI, large, rule stated) at the failing value.",
  "",
  "## Changes from the between-subjects version",
  "",
  "- Source is within participants (12.3); the primer factor is replaced by the fixed block 2; the practice covariate and the main0r and main1r settings are gone (12.1.2).",
  "- Each person sees all ten scenes: eight in block 1, two in block 2 (before: eight of ten, the other two kept for the \"would\" block). Ten lists replace five.",
  "- Random effects follow 1.8 revised: by-participant and by-scene slopes for the source, item and amount codes (scope) and for the source and amount codes (G).",
  "- G is estimated from block 1 alone; the instrument check from the registration's rule model on the four large-addition trials of both blocks.",
  "- New generating terms: participant-by-source SD 0.25 (creativity) and 0.5 (log-odds), and participant-by-block SD 0.5 (log-odds). sens15 raises every participant-by-cell SD by 15/7.",
  "- New settings: fallback (fall0, fall1) for every family; G at the bound; the instrument check at a failing value; the planning scenarios of G in main1 and fall1.",
  "",
  "## Timing",
  "",
  sprintf("Mean seconds in this run (%d cores in parallel): scope %.2f per fit (three account fits per dataset, five in the residue datasets); G and instrument check %.2f per dataset (G fit %.2f, each instrument-check fit %.2f); Laplace check, nAGQ = 1, %.2f per G fit and %.2f per instrument-check fit. Estimated full run at the default numbers of datasets (%d, %d, %d) on 11 cores: %.0f minutes (scope %.0f, G and instrument check %.0f, Laplace %.0f), from each setting's mean time. Elapsed this run: %.1f minutes.",
          opt$cores, sec_scope, sec_g, sec_g_fit, sec_ic_fit, sec_lap_g, sec_lap_ic, DEFAULT_REPS$reps,
          DEFAULT_REPS$reps_small, DEFAULT_REPS$reps_laplace, full_min,
          full_sec[["scope"]] / 660, full_sec[["G"]] / 660, full_sec[["laplace"]] / 660,
          as.numeric(difftime(Sys.time(), started, units = "mins"))),
  "",
  "## Software and checksums",
  "",
  sprintf("- %s; %s; %s", si$R.version$version.string, si$platform, si$running),
  sprintf("- Attached packages: %s", pkg_line(si$otherPkgs)),
  sprintf("- Loaded packages: %s", pkg_line(si$loadedOnly)),
  sprintf("- Run date: %s", run_date),
  sprintf("- SHA-256 of sim_A1.R: %s", sha256(script_path)),
  sprintf("- SHA-256 of sim_common.R: %s", sha256(file.path(script_dir(), "sim_common.R"))))
writeLines(report, file.path(out_dir, paste0("A1_sim", TAG, ".md")))

cat("\nCriteria (scope):\n")
print(crit, row.names = FALSE)
cat("\nCriteria (G and instrument check):\n")
print(gcrit, row.names = FALSE)
cat(sprintf("\nSeconds: scope %.2f per fit; G and instrument check %.2f per dataset (G %.2f, IC %.2f per fit); Laplace %.2f per G fit, %.2f per IC fit. Full run on 11 cores about %.0f minutes.\n",
            sec_scope, sec_g, sec_g_fit, sec_ic_fit, sec_lap_g, sec_lap_ic, full_min))
if (n_dropped > 0) {
  print(dropped[dropped$dropped > 0, ], row.names = FALSE)
  stop(sprintf("%d datasets dropped", n_dropped))
}

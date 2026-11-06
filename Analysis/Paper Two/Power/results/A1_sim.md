# Study A1: sample-size simulation (within-subjects design)

Run date 2026-10-29. Datasets: 1000 per main setting and planning scenario at the target, 500 per bound, sensitivity and fallback setting, 200 for the Laplace check. Cores: 10. Datasets dropped: 0.

## Criteria

Scope family (S1, S2). Criteria of 1.10: (a) the generating account is supported in at least .80 of datasets with no scene-by-source variation and at least .70 with 0.10 SD; (b) every rival is supported in at most .05. All three accounts are rivals; none is compatible.

| Sample | Lowest generating rate, scene-by-source SD 0 | Lowest generating rate, scene-by-source SD 0.10 | Highest rival rate | (a) at least .80 and .70 | (b) every rival at most .05 |
|---|---|---|---|---|---|
| Target (N = 140; main0, main1) | 0.88 | 0.77 | 0.02 | yes | yes |
| Fallback (N = 120; fall0, fall1) | 0.79 | 0.68 | 0.03 | no | yes |

Gate G and the instrument check. The thresholds are 1.10's, applied to the pass rate of the gate and to the verdict of the check. "True value" for the instrument check is P(divided | AI, large, rule stated) in block 2; the check should find the divided option usable when it is at least 1/3 and not usable when it is below.

| Check | Threshold | Target | Fallback | Met at target | Met at fallback |
|---|---|---|---|---|---|
| G passes, planning .30 vs .15, ICC .25, scene-by-source SD 0 | at least .80 | 0.84 | 0.81 | yes | yes |
| G passes, planning .30 vs .15, ICC .50, scene-by-source SD 0 | at least .80 | 0.90 | 0.88 | yes | yes |
| G passes, planning .30 vs .15, scene-by-source SD 0.3, lower of the two ICCs | at least .70 | 0.85 | 0.82 | yes | yes |
| G passes, planning .40 vs .15, scene-by-source SD 0, lower of the two ICCs | at least .80 | 1.00 | 1.00 | yes | yes |
| G passes falsely, planning .15 vs .15, highest over both ICCs and scene-by-source SDs | at most .05 | 0.01 | 0.02 | yes | yes |
| G passes, patterns with true G 0.50 (Office, scoped credit), scene-by-source SD 0: lowest | at least .80 | 1.00 | 1.00 | yes | yes |
| G passes, patterns with true G 0.50, scene-by-source SD 0.3: lowest | at least .70 | 1.00 | 1.00 | yes | yes |
| G passes falsely, patterns with true G 0 (area, taint, provenance ignored): highest | at most .05 | 0.02 | 0.03 | yes | yes |
| Instrument check finds the option usable, true value at least 1/3 (Office, Area, Scoped credit): lowest | at least .80 | 1.00 | 1.00 | yes | yes |
| Instrument check finds the option usable, true value below 1/3 (Taint, Provenance ignored; and 0.20 under every pattern): highest | at most .05 | 0.35 | 0.40 | no | no |

## Each generating account's own rate in every setting

Scope family, share of datasets in which the generating account is supported:

| Generating account | main0 | main1 | bound0 | bound1 | sens15 | fall0 | fall1 |
|---|---|---|---|---|---|---|---|
| Scoped credit, the Office's premise Q1, or a literal reading of each item | 0.96 | 0.83 | 0.89 | 0.76 | 0.74 | 0.94 | 0.78 |
| Taint, at any strength | 0.93 | 0.92 | 0.88 | 0.76 | 0.90 | 0.84 | 0.86 |
| Provenance ignored | 0.88 | 0.77 | 0.88 | 0.75 | 0.68 | 0.79 | 0.68 |

Scope family, highest support rate of any other rival account:

| Generating account | main0 | main1 | bound0 | bound1 | sens15 | fall0 | fall1 |
|---|---|---|---|---|---|---|---|
| Scoped credit, the Office's premise Q1, or a literal reading of each item | 0.01 | 0.02 | 0.04 | 0.04 | 0.02 | 0.02 | 0.03 |
| Taint, at any strength | 0.00 | 0.00 | 0.03 | 0.03 | 0.00 | 0.00 | 0.00 |
| Provenance ignored | 0.02 | 0.02 | 0.03 | 0.02 | 0.02 | 0.02 | 0.02 |

Gate G, share of datasets in which G passes, by decision pattern (true G 0.50 under Office and scoped credit, 0 under the others):

| Decision pattern | main0 | main1 | sens15 | fall0 | fall1 |
|---|---|---|---|---|---|
| Office | 1.00 | 1.00 | 1.00 | 1.00 | 1.00 |
| Area | 0.01 | 0.02 | 0.01 | 0.02 | 0.03 |
| Taint | 0.01 | 0.00 | 0.00 | 0.00 | 0.00 |
| Scoped credit | 1.00 | 1.00 | 1.00 | 1.00 | 1.00 |
| Provenance ignored | 0.00 | 0.00 | 0.01 | 0.00 | 0.01 |

Instrument check, share of datasets in which it finds the divided option usable, under each pattern's own block-2 value (Office 0.75, area and scoped credit 0.60, taint and provenance ignored 0.10):

| Decision pattern | main0 | main1 | sens15 | fall0 | fall1 |
|---|---|---|---|---|---|
| Office | 1.00 | 1.00 | 1.00 | 1.00 | 1.00 |
| Area | 1.00 | 1.00 | 1.00 | 1.00 | 1.00 |
| Taint | 0.00 | 0.00 | 0.00 | 0.00 | 0.00 |
| Scoped credit | 1.00 | 1.00 | 1.00 | 1.00 | 1.00 |
| Provenance ignored | 0.00 | 0.00 | 0.00 | 0.00 | 0.00 |

Instrument check, the same with P(divided | AI, large, rule stated) set to the failing value 0.20 (same datasets otherwise):

| Decision pattern | main0 | main1 | sens15 | fall0 | fall1 |
|---|---|---|---|---|---|
| Office | 0.24 | 0.29 | 0.24 | 0.35 | 0.29 |
| Area | 0.18 | 0.21 | 0.15 | 0.26 | 0.27 |
| Taint | 0.31 | 0.35 | 0.32 | 0.38 | 0.38 |
| Scoped credit | 0.24 | 0.31 | 0.29 | 0.32 | 0.31 |
| Provenance ignored | 0.34 | 0.32 | 0.33 | 0.38 | 0.40 |

Mean estimate of P(divided | AI, large, rule stated) by the instrument-check model (nAGQ = 0), over the pattern settings: 0.233 with the failing value 0.20; 0.722 at a true 0.75 (Office); 0.133 at a true 0.10 (taint, provenance ignored).

Gate G at the bound (true G 0.10, the probability bound, where a pass is close to chance):

| setting | N | generating | n_datasets | true_G | G_pass | G_mean_est | G_mean_se |
|---|---|---|---|---|---|---|---|
| bound0 | 140 | Office, G at the bound (AI 0.20 vs hand-made 0.10) | 500 | 0.10 | 0.54 | 0.10 | 0.04 |
| bound1 | 140 | Office, G at the bound (AI 0.20 vs hand-made 0.10) | 500 | 0.10 | 0.57 | 0.11 | 0.04 |

Gate G under the planning scenarios of the registration's Rationale (participant SD from the intraclass correlation; every other component as in the main settings: participant-by-amount, participant-by-source and participant-by-block SD 0.5, scene SD 0.4, scene-by-source SD 0 in main0 and fall0, 0.3 in main1 and fall1; cells other than the two large block-1 cells take the Office's values; .40 against .15 runs only without scene-by-source variation). The .30 and .15 rows at main0 and main1 are the gate's rows in the smallest-sample search:

| setting | N | generating | n_datasets | true_G | G_pass | G_mean_est | G_mean_se |
|---|---|---|---|---|---|---|---|
| main0 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 1,000 | 0.15 | 0.84 | 0.15 | 0.05 |
| main0 | 140 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.25 | 1,000 | 0.25 | 1.00 | 0.24 | 0.05 |
| main0 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 1,000 | 0.00 | 0.01 | -0.00 | 0.04 |
| main0 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 1,000 | 0.15 | 0.90 | 0.15 | 0.04 |
| main0 | 140 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.50 | 1,000 | 0.25 | 1.00 | 0.24 | 0.04 |
| main0 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 1,000 | 0.00 | 0.01 | -0.00 | 0.04 |
| main1 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 1,000 | 0.15 | 0.85 | 0.15 | 0.05 |
| main1 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 1,000 | 0.00 | 0.01 | -0.00 | 0.04 |
| main1 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 1,000 | 0.15 | 0.86 | 0.15 | 0.04 |
| main1 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 1,000 | 0.00 | 0.01 | -0.00 | 0.04 |
| fall0 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 500 | 0.15 | 0.81 | 0.15 | 0.05 |
| fall0 | 120 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.25 | 500 | 0.25 | 1.00 | 0.24 | 0.05 |
| fall0 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 500 | 0.00 | 0.02 | 0.00 | 0.05 |
| fall0 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 500 | 0.15 | 0.88 | 0.15 | 0.05 |
| fall0 | 120 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.50 | 500 | 0.25 | 1.00 | 0.24 | 0.05 |
| fall0 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 500 | 0.00 | 0.01 | -0.00 | 0.04 |
| fall1 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 500 | 0.15 | 0.82 | 0.14 | 0.05 |
| fall1 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 500 | 0.00 | 0.01 | 0.00 | 0.05 |
| fall1 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 500 | 0.15 | 0.84 | 0.15 | 0.05 |
| fall1 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 500 | 0.00 | 0.01 | 0.00 | 0.04 |

S2 at Paper One's residue (S1 at 1.5 x bound), first datasets of main0 and main1:

| setting | N | generating | n_datasets | S2_zero | S2_positive | S2_undetermined | support_scoped_credit | support_taint |
|---|---|---|---|---|---|---|---|---|
| main0 | 140 | S2 residue 0.10 | 500 | 0.63 | 0.34 | 0.03 | 0.63 | 0.34 |
| main0 | 140 | S2 residue 0.15 | 500 | 0.31 | 0.66 | 0.03 | 0.31 | 0.66 |
| main1 | 140 | S2 residue 0.10 | 500 | 0.49 | 0.26 | 0.25 | 0.49 | 0.26 |
| main1 | 140 | S2 residue 0.15 | 500 | 0.26 | 0.52 | 0.21 | 0.26 | 0.52 |

## Settings

Scope family (all three accounts generate data in every setting; SDs on the 1-to-5 scale):

| Setting | N | Nonzero contrasts | Scene-by-source SD | Participant-by-source SD | Participant-by-item SD | Datasets |
|---|---|---|---|---|---|---|
| main0 | 140 | 1.5 x bound (0.336) | 0.000 | 0.250 | 0.250 | 1,000 |
| main1 | 140 | 1.5 x bound (0.336) | 0.100 | 0.250 | 0.250 | 1,000 |
| bound0 | 140 | at the bound (0.224) | 0.000 | 0.250 | 0.250 | 500 |
| bound1 | 140 | at the bound (0.224) | 0.100 | 0.250 | 0.250 | 500 |
| sens15 | 140 | 1.5 x bound (0.336) | 0.000 | 0.536 | 0.536 | 500 |
| fall0 | 120 | 1.5 x bound (0.336) | 0.000 | 0.250 | 0.250 | 500 |
| fall1 | 120 | 1.5 x bound (0.336) | 0.100 | 0.250 | 0.250 | 500 |

Gate G and the instrument check (SDs on the log-odds scale):

| Setting | N | Generating | True G | True P(divided, AI, block 2) | Participant SD | Participant-by-amount SD | Participant-by-source SD | Participant-by-block SD | Scene SD | Scene-by-source SD | Datasets | Laplace check |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| main0 | 140 | Office | 0.500 | 0.750 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 1,000 | G and instrument check |
| main0 | 140 | Area | 0.000 | 0.600 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 1,000 | G and instrument check |
| main0 | 140 | Taint | 0.000 | 0.100 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 1,000 | G and instrument check |
| main0 | 140 | Scoped credit | 0.500 | 0.600 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 1,000 | G and instrument check |
| main0 | 140 | Provenance ignored | 0.000 | 0.100 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 1,000 | G and instrument check |
| main1 | 140 | Office | 0.500 | 0.750 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 1,000 | no |
| main1 | 140 | Area | 0.000 | 0.600 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 1,000 | no |
| main1 | 140 | Taint | 0.000 | 0.100 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 1,000 | no |
| main1 | 140 | Scoped credit | 0.500 | 0.600 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 1,000 | no |
| main1 | 140 | Provenance ignored | 0.000 | 0.100 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 1,000 | no |
| sens15 | 140 | Office | 0.500 | 0.750 | 1.500 | 1.071 | 1.071 | 1.071 | 0.400 | 0.000 | 500 | no |
| sens15 | 140 | Area | 0.000 | 0.600 | 1.500 | 1.071 | 1.071 | 1.071 | 0.400 | 0.000 | 500 | no |
| sens15 | 140 | Taint | 0.000 | 0.100 | 1.500 | 1.071 | 1.071 | 1.071 | 0.400 | 0.000 | 500 | no |
| sens15 | 140 | Scoped credit | 0.500 | 0.600 | 1.500 | 1.071 | 1.071 | 1.071 | 0.400 | 0.000 | 500 | no |
| sens15 | 140 | Provenance ignored | 0.000 | 0.100 | 1.500 | 1.071 | 1.071 | 1.071 | 0.400 | 0.000 | 500 | no |
| fall0 | 120 | Office | 0.500 | 0.750 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 500 | no |
| fall0 | 120 | Area | 0.000 | 0.600 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 500 | no |
| fall0 | 120 | Taint | 0.000 | 0.100 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 500 | no |
| fall0 | 120 | Scoped credit | 0.500 | 0.600 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 500 | no |
| fall0 | 120 | Provenance ignored | 0.000 | 0.100 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 500 | no |
| fall1 | 120 | Office | 0.500 | 0.750 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 500 | no |
| fall1 | 120 | Area | 0.000 | 0.600 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 500 | no |
| fall1 | 120 | Taint | 0.000 | 0.100 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 500 | no |
| fall1 | 120 | Scoped credit | 0.500 | 0.600 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 500 | no |
| fall1 | 120 | Provenance ignored | 0.000 | 0.100 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 500 | no |
| bound0 | 140 | Office, G at the bound (AI 0.20 vs hand-made 0.10) | 0.100 | 0.750 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 500 | no |
| bound1 | 140 | Office, G at the bound (AI 0.20 vs hand-made 0.10) | 0.100 | 0.750 | 1.500 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 500 | no |
| main0 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0.150 | 0.750 | 1.047 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 1,000 | G |
| main0 | 140 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.25 | 0.250 | 0.750 | 1.047 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 1,000 | no |
| main0 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0.000 | 0.750 | 1.047 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 1,000 | G |
| main0 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0.150 | 0.750 | 1.814 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 1,000 | G |
| main0 | 140 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.50 | 0.250 | 0.750 | 1.814 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 1,000 | no |
| main0 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0.000 | 0.750 | 1.814 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 1,000 | G |
| main1 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0.150 | 0.750 | 1.047 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 1,000 | no |
| main1 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0.000 | 0.750 | 1.047 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 1,000 | no |
| main1 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0.150 | 0.750 | 1.814 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 1,000 | no |
| main1 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0.000 | 0.750 | 1.814 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 1,000 | no |
| fall0 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0.150 | 0.750 | 1.047 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 500 | no |
| fall0 | 120 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.25 | 0.250 | 0.750 | 1.047 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 500 | no |
| fall0 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0.000 | 0.750 | 1.047 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 500 | no |
| fall0 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0.150 | 0.750 | 1.814 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 500 | no |
| fall0 | 120 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.50 | 0.250 | 0.750 | 1.814 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 500 | no |
| fall0 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0.000 | 0.750 | 1.814 | 0.500 | 0.500 | 0.500 | 0.400 | 0.000 | 500 | no |
| fall1 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0.150 | 0.750 | 1.047 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 500 | no |
| fall1 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0.000 | 0.750 | 1.047 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 500 | no |
| fall1 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0.150 | 0.750 | 1.814 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 500 | no |
| fall1 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0.000 | 0.750 | 1.814 | 0.500 | 0.500 | 0.500 | 0.400 | 0.300 | 500 | no |

## Design

- Samples: target 140 analyzable (14 per list), fallback 120 (12 per list). Every participant sees all ten Set A scenes once, one condition per scene. Block 1 (no rule stated): eight trials, source (AI, hand-made) x amount (none, small, medium, large), one trial per cell. Block 2 (after the rule paragraph and its recall items): two trials, AI large and hand-made large. Trial order within a block does not enter the generating model.
- Lists (12.3 and the registration's Randomization paragraph): scenes in the interleaved order SA01, SA06, SA02, SA07, SA03, SA08, SA04, SA09, SA05, SA10; list k puts the scene at position (j + k) modulo 10 in slot j. Slots 0 and 1 carry no change, 2 and 3 the small addition, 4 and 5 the medium, 6 and 7 the large; the AI story takes slots 0, 2, 5 and 7 and the hand-made story slots 1, 3, 4 and 6; slot 8 (AI) and slot 9 (hand-made) are block 2, both large. Within each list each source in block 1 falls on two scenes with a person and two without, each amount on one of each, and so do the written-reason trials (slots 2 and 7), the stop-others trials (6 and 7) and block 2. Across the ten lists every scene appears in every slot once. The script checks these properties before it runs.
- Participants cycle through the ten lists; the order of the two creativity items alternates within each list.

| List | Slot 0: AI none | Slot 1: hand-made none | Slot 2: AI small | Slot 3: hand-made small | Slot 4: hand-made medium | Slot 5: AI medium | Slot 6: hand-made large | Slot 7: AI large | Slot 8: AI large (block 2) | Slot 9: hand-made large (block 2) |
|---|---|---|---|---|---|---|---|---|---|---|
| 0 | SA01 | SA06 | SA02 | SA07 | SA03 | SA08 | SA04 | SA09 | SA05 | SA10 |
| 1 | SA06 | SA02 | SA07 | SA03 | SA08 | SA04 | SA09 | SA05 | SA10 | SA01 |
| 2 | SA02 | SA07 | SA03 | SA08 | SA04 | SA09 | SA05 | SA10 | SA01 | SA06 |
| 3 | SA07 | SA03 | SA08 | SA04 | SA09 | SA05 | SA10 | SA01 | SA06 | SA02 |
| 4 | SA03 | SA08 | SA04 | SA09 | SA05 | SA10 | SA01 | SA06 | SA02 | SA07 |
| 5 | SA08 | SA04 | SA09 | SA05 | SA10 | SA01 | SA06 | SA02 | SA07 | SA03 |
| 6 | SA04 | SA09 | SA05 | SA10 | SA01 | SA06 | SA02 | SA07 | SA03 | SA08 |
| 7 | SA09 | SA05 | SA10 | SA01 | SA06 | SA02 | SA07 | SA03 | SA08 | SA04 |
| 8 | SA05 | SA10 | SA01 | SA06 | SA02 | SA07 | SA03 | SA08 | SA04 | SA09 |
| 9 | SA10 | SA01 | SA06 | SA02 | SA07 | SA03 | SA08 | SA04 | SA09 | SA05 |

## Models and codes

- Codes: source hand-made +0.5, AI -0.5; item whole image +0.5, addition -0.5; item order whole first -0.5, addition first +0.5; amount by orthonormal polynomial contrasts (am1 to am3 over none to large for the decision, am1 and am2 over small to large for creativity).
- Scope family: linear mixed model (lmerTest, REML) on the two creativity items stacked over the six block-1 change trials; S1 and S2 by the state rule with Satterthwaite df and bound 0.224. Label effect = hand-made minus AI, averaged over amounts; S2 = label effect on the addition item, S1 = label effect on the whole-image item minus S2. First model tried: `y ~ src * item * (am1 + am2) + order + (1 + am1 + am2 + item + src || pid) + (1 + am1 + am2 + item + src || scene)`.
- Gate G: logistic mixed model (glmer, nAGQ = 0 in the main runs; nAGQ = 1, the registered Laplace fit, in the Laplace check below) on divided (1) against either other option (0) over the eight block-1 trials. G = population-averaged P(divided | AI, large) minus P(divided | hand-made, large), probabilities averaged over the fitted random effects, delta-method standard error; passes if one-sided p < .05 and estimate at least 0.10. First model tried: `y ~ src * (am1 + am2 + am3) + order + (1 + am1 + am2 + am3 + src || pid) + (1 + am1 + am2 + am3 + src || scene)`.
- Instrument check: the registration's rule model, a logistic mixed model on the four large-addition trials, two in each block (block coded -0.5 for block 1 and +0.5 for block 2), with a participant intercept only and by-scene slopes for source and block; population-averaged P(divided | AI, large, block 2) with a delta-method 95 percent interval; the divided option is not usable if the upper end is below 1/3. First model tried: `y ~ src * blk + order + (1 | pid) + (1 + blk + src || scene)`.

## Removal rule and convergence

Every model is fitted by fit_registered() in sim_common.R (1.8 revised). The linear model uses lme4's default settings. The logistic models use lme4's defaults except the optimizer, bobyqa in both stages of glmer in place of the default second stage, Nelder-Mead (results/A1_convergence_note.md). A fit fails when it stops with an error, fails to converge (the optimizer returns a nonzero code, or lme4 or lmerTest warns that the model failed to converge; for the logistic models also when a random-effect SD exceeds 10 on the log-odds scale, a variance running off toward infinity) or is singular. After a failed fit one random term is removed and the model refitted: interaction slopes first (none are registered here), then the slope with the smallest estimated variance in the failed fit, then the scene intercept. The model left after the last removal is accepted as it is. Slopes are listed smallest generating variance first, scene before participant; the order breaks ties and chooses the slope to remove when a fit stops with an error:

- scope: scene:am1, scene:am2, scene:item, scene:src, pid:am1, pid:am2, pid:item, pid:src
- G: scene:am1, scene:am2, scene:am3, scene:src, pid:am1, pid:am2, pid:am3, pid:src
- instrument check: scene:blk, scene:src

## Fit diagnostics

removed_k: share of fits whose accepted model had k random terms removed (0 = the first model); kept_*: share keeping that term; removals_after_convergence_failure: share of all removals that followed a convergence failure that was not also a singular fit (the rest followed a singular fit or an error); fit_failed: share with no usable fit. Pooled over all settings of each family:

Scope family (15,500 fits):

| removed_0 | removed_1 | removed_2 | removed_3 | removed_4 | removed_5 | removed_6 | removed_7 | removed_8 | removed_9 | kept_scene_am1 | kept_scene_am2 | kept_scene_item | kept_scene_src | kept_pid_am1 | kept_pid_am2 | kept_pid_item | kept_pid_src | kept_scene_intercept | removals_after_convergence_failure | accepted_with_gradient_warning | fit_failed |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 0.02 | 0.08 | 0.20 | 0.31 | 0.25 | 0.11 | 0.02 | 0.00 | 0.00 | 0.00 | 0.41 | 0.40 | 0.44 | 0.64 | 0.51 | 0.50 | 0.99 | 1.00 | 1.00 | 0.03 | 0.00 | 0.00 |

Gate G, nAGQ = 0 (33,500 fits):

| removed_0 | removed_1 | removed_2 | removed_3 | removed_4 | removed_5 | removed_6 | removed_7 | removed_8 | removed_9 | kept_scene_am1 | kept_scene_am2 | kept_scene_am3 | kept_scene_src | kept_pid_am1 | kept_pid_am2 | kept_pid_am3 | kept_pid_src | kept_scene_intercept | removals_after_convergence_failure | accepted_with_gradient_warning | fit_failed |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 0.00 | 0.00 | 0.00 | 0.02 | 0.10 | 0.23 | 0.30 | 0.19 | 0.06 | 0.09 | 0.23 | 0.22 | 0.23 | 0.32 | 0.23 | 0.22 | 0.20 | 0.37 | 0.91 | 0.00 | 0.00 | 0.00 |

Instrument check, nAGQ = 0 (own values and failing value) (67,000 fits):

| removed_0 | removed_1 | removed_2 | removed_3 | kept_scene_blk | kept_scene_src | kept_scene_intercept | removals_after_convergence_failure | accepted_with_gradient_warning | fit_failed |
|---|---|---|---|---|---|---|---|---|---|
| 0.06 | 0.29 | 0.37 | 0.27 | 0.19 | 0.23 | 0.73 | 0.00 | 0.00 | 0.00 |

Gate G, Laplace (Office, Area, Taint, Scoped credit, Provenance ignored, P(divided | AI) 0.30 vs hand-made 0.15, ICC 0.25, P(divided | AI) 0.15 vs hand-made 0.15, ICC 0.25, P(divided | AI) 0.30 vs hand-made 0.15, ICC 0.50, P(divided | AI) 0.15 vs hand-made 0.15, ICC 0.50) (1,800 fits):

| removed_0 | removed_1 | removed_2 | removed_3 | removed_4 | removed_5 | removed_6 | removed_7 | removed_8 | removed_9 | kept_scene_am1 | kept_scene_am2 | kept_scene_am3 | kept_scene_src | kept_pid_am1 | kept_pid_am2 | kept_pid_am3 | kept_pid_src | kept_scene_intercept | removals_after_convergence_failure | accepted_with_gradient_warning | fit_failed |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 0.00 | 0.00 | 0.02 | 0.09 | 0.17 | 0.26 | 0.24 | 0.08 | 0.03 | 0.10 | 0.20 | 0.18 | 0.21 | 0.19 | 0.44 | 0.46 | 0.38 | 0.57 | 0.90 | 0.21 | 0.00 | 0.00 |

Instrument check, Laplace (2,000 fits):

| removed_0 | removed_1 | removed_2 | removed_3 | kept_scene_blk | kept_scene_src | kept_scene_intercept | removals_after_convergence_failure | accepted_with_gradient_warning | fit_failed |
|---|---|---|---|---|---|---|---|---|---|
| 0.05 | 0.27 | 0.39 | 0.29 | 0.20 | 0.18 | 0.71 | 0.00 | 0.00 | 0.00 |

By setting, scope family:

| setting | N | generating | removed_0 | removed_1 | removed_2 | removed_3 | removed_4 | removed_5 | removed_6 | removed_7 | removed_8 | removed_9 | kept_scene_am1 | kept_scene_am2 | kept_scene_item | kept_scene_src | kept_pid_am1 | kept_pid_am2 | kept_pid_item | kept_pid_src | kept_scene_intercept | removals_after_convergence_failure | accepted_with_gradient_warning | fit_failed |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| main0 | 140 | Scoped credit, the Office's premise Q1, or a literal reading of each item | 0.02 | 0.07 | 0.17 | 0.29 | 0.27 | 0.14 | 0.04 | 0.00 | 0.00 | 0.00 | 0.42 | 0.40 | 0.46 | 0.42 | 0.51 | 0.49 | 0.99 | 1.00 | 1.00 | 0.03 | 0.00 | 0.00 |
| main0 | 140 | Taint, at any strength | 0.02 | 0.07 | 0.17 | 0.31 | 0.25 | 0.14 | 0.04 | 0.00 | 0.00 | 0.00 | 0.41 | 0.40 | 0.47 | 0.42 | 0.51 | 0.50 | 0.99 | 1.00 | 1.00 | 0.03 | 0.00 | 0.00 |
| main0 | 140 | Provenance ignored | 0.02 | 0.07 | 0.16 | 0.31 | 0.27 | 0.14 | 0.04 | 0.00 | 0.00 | 0.00 | 0.41 | 0.39 | 0.46 | 0.41 | 0.52 | 0.49 | 0.99 | 1.00 | 1.00 | 0.04 | 0.00 | 0.00 |
| main1 | 140 | Scoped credit, the Office's premise Q1, or a literal reading of each item | 0.03 | 0.10 | 0.25 | 0.34 | 0.23 | 0.05 | 0.00 | 0.00 | 0.00 | 0.00 | 0.42 | 0.41 | 0.43 | 0.91 | 0.51 | 0.52 | 0.99 | 1.00 | 1.00 | 0.04 | 0.00 | 0.00 |
| main1 | 140 | Taint, at any strength | 0.03 | 0.10 | 0.24 | 0.34 | 0.24 | 0.05 | 0.00 | 0.00 | 0.00 | 0.00 | 0.42 | 0.40 | 0.44 | 0.90 | 0.52 | 0.52 | 0.99 | 1.00 | 1.00 | 0.03 | 0.00 | 0.00 |
| main1 | 140 | Provenance ignored | 0.03 | 0.11 | 0.23 | 0.34 | 0.24 | 0.05 | 0.00 | 0.00 | 0.00 | 0.00 | 0.42 | 0.41 | 0.43 | 0.90 | 0.51 | 0.51 | 1.00 | 1.00 | 1.00 | 0.03 | 0.00 | 0.00 |
| bound0 | 140 | Scoped credit, the Office's premise Q1, or a literal reading of each item | 0.02 | 0.05 | 0.19 | 0.30 | 0.25 | 0.16 | 0.04 | 0.00 | 0.00 | 0.00 | 0.42 | 0.37 | 0.46 | 0.41 | 0.50 | 0.50 | 1.00 | 1.00 | 1.00 | 0.03 | 0.00 | 0.00 |
| bound0 | 140 | Taint, at any strength | 0.01 | 0.05 | 0.18 | 0.30 | 0.26 | 0.16 | 0.03 | 0.00 | 0.00 | 0.00 | 0.43 | 0.37 | 0.44 | 0.40 | 0.50 | 0.50 | 1.00 | 1.00 | 1.00 | 0.03 | 0.00 | 0.00 |
| bound0 | 140 | Provenance ignored | 0.02 | 0.05 | 0.18 | 0.29 | 0.26 | 0.17 | 0.03 | 0.00 | 0.00 | 0.00 | 0.42 | 0.38 | 0.45 | 0.42 | 0.50 | 0.50 | 1.00 | 1.00 | 1.00 | 0.04 | 0.00 | 0.00 |
| bound1 | 140 | Scoped credit, the Office's premise Q1, or a literal reading of each item | 0.02 | 0.11 | 0.27 | 0.33 | 0.21 | 0.05 | 0.01 | 0.00 | 0.00 | 0.00 | 0.43 | 0.39 | 0.41 | 0.93 | 0.55 | 0.51 | 0.99 | 1.00 | 1.00 | 0.04 | 0.00 | 0.00 |
| bound1 | 140 | Taint, at any strength | 0.02 | 0.11 | 0.27 | 0.33 | 0.22 | 0.05 | 0.01 | 0.00 | 0.00 | 0.00 | 0.42 | 0.40 | 0.40 | 0.93 | 0.54 | 0.52 | 0.98 | 1.00 | 1.00 | 0.03 | 0.00 | 0.00 |
| bound1 | 140 | Provenance ignored | 0.02 | 0.12 | 0.26 | 0.34 | 0.21 | 0.06 | 0.01 | 0.00 | 0.00 | 0.00 | 0.41 | 0.40 | 0.42 | 0.93 | 0.55 | 0.51 | 0.99 | 1.00 | 1.00 | 0.04 | 0.00 | 0.00 |
| sens15 | 140 | Scoped credit, the Office's premise Q1, or a literal reading of each item | 0.02 | 0.06 | 0.19 | 0.25 | 0.29 | 0.14 | 0.04 | 0.00 | 0.00 | 0.00 | 0.38 | 0.39 | 0.44 | 0.43 | 0.51 | 0.50 | 1.00 | 1.00 | 1.00 | 0.03 | 0.00 | 0.00 |
| sens15 | 140 | Taint, at any strength | 0.02 | 0.07 | 0.18 | 0.26 | 0.27 | 0.16 | 0.04 | 0.00 | 0.00 | 0.00 | 0.39 | 0.38 | 0.44 | 0.42 | 0.51 | 0.50 | 1.00 | 1.00 | 1.00 | 0.03 | 0.00 | 0.00 |
| sens15 | 140 | Provenance ignored | 0.02 | 0.07 | 0.17 | 0.26 | 0.30 | 0.15 | 0.04 | 0.00 | 0.00 | 0.00 | 0.39 | 0.39 | 0.44 | 0.43 | 0.51 | 0.49 | 1.00 | 1.00 | 1.00 | 0.03 | 0.00 | 0.00 |
| fall0 | 120 | Scoped credit, the Office's premise Q1, or a literal reading of each item | 0.02 | 0.03 | 0.19 | 0.28 | 0.30 | 0.14 | 0.04 | 0.00 | 0.00 | 0.00 | 0.37 | 0.41 | 0.42 | 0.41 | 0.51 | 0.51 | 0.99 | 1.00 | 1.00 | 0.03 | 0.00 | 0.00 |
| fall0 | 120 | Taint, at any strength | 0.02 | 0.05 | 0.18 | 0.28 | 0.31 | 0.14 | 0.03 | 0.00 | 0.00 | 0.00 | 0.39 | 0.41 | 0.42 | 0.42 | 0.52 | 0.50 | 0.99 | 1.00 | 1.00 | 0.03 | 0.00 | 0.00 |
| fall0 | 120 | Provenance ignored | 0.02 | 0.06 | 0.16 | 0.30 | 0.30 | 0.14 | 0.03 | 0.00 | 0.00 | 0.00 | 0.38 | 0.41 | 0.42 | 0.43 | 0.52 | 0.51 | 0.99 | 1.00 | 1.00 | 0.03 | 0.00 | 0.00 |
| fall1 | 120 | Scoped credit, the Office's premise Q1, or a literal reading of each item | 0.04 | 0.13 | 0.24 | 0.33 | 0.19 | 0.07 | 0.01 | 0.00 | 0.00 | 0.00 | 0.46 | 0.44 | 0.46 | 0.89 | 0.53 | 0.49 | 0.98 | 1.00 | 1.00 | 0.03 | 0.00 | 0.00 |
| fall1 | 120 | Taint, at any strength | 0.04 | 0.14 | 0.23 | 0.34 | 0.18 | 0.06 | 0.01 | 0.00 | 0.00 | 0.00 | 0.46 | 0.45 | 0.46 | 0.89 | 0.54 | 0.50 | 0.99 | 1.00 | 1.00 | 0.02 | 0.00 | 0.00 |
| fall1 | 120 | Provenance ignored | 0.04 | 0.13 | 0.23 | 0.35 | 0.18 | 0.07 | 0.01 | 0.00 | 0.00 | 0.00 | 0.47 | 0.44 | 0.46 | 0.89 | 0.53 | 0.49 | 0.99 | 1.00 | 1.00 | 0.02 | 0.00 | 0.00 |

By setting, gate G:

| setting | N | generating | removed_0 | removed_1 | removed_2 | removed_3 | removed_4 | removed_5 | removed_6 | removed_7 | removed_8 | removed_9 | kept_scene_am1 | kept_scene_am2 | kept_scene_am3 | kept_scene_src | kept_pid_am1 | kept_pid_am2 | kept_pid_am3 | kept_pid_src | kept_scene_intercept | removals_after_convergence_failure | accepted_with_gradient_warning | fit_failed |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| main0 | 140 | Office | 0.00 | 0.00 | 0.00 | 0.01 | 0.05 | 0.16 | 0.31 | 0.28 | 0.09 | 0.10 | 0.23 | 0.21 | 0.23 | 0.21 | 0.17 | 0.14 | 0.15 | 0.30 | 0.90 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | Area | 0.00 | 0.00 | 0.00 | 0.01 | 0.07 | 0.20 | 0.31 | 0.27 | 0.09 | 0.05 | 0.24 | 0.22 | 0.23 | 0.22 | 0.17 | 0.19 | 0.21 | 0.33 | 0.95 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | Taint | 0.00 | 0.00 | 0.00 | 0.03 | 0.10 | 0.27 | 0.28 | 0.14 | 0.04 | 0.13 | 0.22 | 0.21 | 0.22 | 0.24 | 0.25 | 0.28 | 0.28 | 0.40 | 0.87 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | Scoped credit | 0.00 | 0.00 | 0.00 | 0.01 | 0.04 | 0.17 | 0.30 | 0.30 | 0.10 | 0.08 | 0.23 | 0.19 | 0.24 | 0.22 | 0.14 | 0.16 | 0.13 | 0.31 | 0.92 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | Provenance ignored | 0.00 | 0.00 | 0.00 | 0.02 | 0.12 | 0.22 | 0.31 | 0.14 | 0.04 | 0.15 | 0.21 | 0.22 | 0.22 | 0.20 | 0.26 | 0.27 | 0.29 | 0.37 | 0.85 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | Office | 0.00 | 0.00 | 0.00 | 0.01 | 0.08 | 0.21 | 0.37 | 0.21 | 0.06 | 0.06 | 0.24 | 0.23 | 0.22 | 0.49 | 0.17 | 0.16 | 0.15 | 0.32 | 0.94 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | Area | 0.00 | 0.00 | 0.00 | 0.02 | 0.11 | 0.24 | 0.33 | 0.22 | 0.05 | 0.03 | 0.25 | 0.22 | 0.22 | 0.56 | 0.18 | 0.19 | 0.21 | 0.34 | 0.97 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | Taint | 0.00 | 0.00 | 0.01 | 0.04 | 0.13 | 0.28 | 0.29 | 0.13 | 0.03 | 0.10 | 0.23 | 0.23 | 0.23 | 0.40 | 0.27 | 0.28 | 0.27 | 0.40 | 0.90 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | Scoped credit | 0.00 | 0.00 | 0.00 | 0.01 | 0.08 | 0.21 | 0.36 | 0.22 | 0.08 | 0.04 | 0.25 | 0.23 | 0.22 | 0.49 | 0.17 | 0.17 | 0.14 | 0.28 | 0.95 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | Provenance ignored | 0.00 | 0.00 | 0.01 | 0.04 | 0.14 | 0.27 | 0.28 | 0.14 | 0.04 | 0.10 | 0.22 | 0.20 | 0.23 | 0.41 | 0.27 | 0.29 | 0.26 | 0.37 | 0.90 | 0.00 | 0.00 | 0.00 |
| sens15 | 140 | Office | 0.00 | 0.00 | 0.01 | 0.03 | 0.08 | 0.21 | 0.30 | 0.17 | 0.04 | 0.17 | 0.19 | 0.20 | 0.18 | 0.21 | 0.19 | 0.18 | 0.18 | 0.58 | 0.83 | 0.00 | 0.00 | 0.00 |
| sens15 | 140 | Area | 0.00 | 0.00 | 0.01 | 0.04 | 0.14 | 0.31 | 0.28 | 0.09 | 0.01 | 0.12 | 0.21 | 0.20 | 0.22 | 0.23 | 0.23 | 0.29 | 0.38 | 0.68 | 0.88 | 0.00 | 0.00 | 0.00 |
| sens15 | 140 | Taint | 0.00 | 0.00 | 0.02 | 0.07 | 0.19 | 0.32 | 0.17 | 0.06 | 0.01 | 0.16 | 0.16 | 0.21 | 0.18 | 0.23 | 0.40 | 0.34 | 0.38 | 0.66 | 0.84 | 0.00 | 0.00 | 0.00 |
| sens15 | 140 | Scoped credit | 0.00 | 0.00 | 0.00 | 0.02 | 0.09 | 0.21 | 0.31 | 0.19 | 0.04 | 0.14 | 0.17 | 0.18 | 0.22 | 0.21 | 0.20 | 0.21 | 0.17 | 0.57 | 0.86 | 0.00 | 0.00 | 0.00 |
| sens15 | 140 | Provenance ignored | 0.00 | 0.00 | 0.02 | 0.07 | 0.19 | 0.27 | 0.18 | 0.08 | 0.02 | 0.17 | 0.17 | 0.18 | 0.21 | 0.19 | 0.33 | 0.38 | 0.36 | 0.65 | 0.83 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | Office | 0.00 | 0.00 | 0.00 | 0.00 | 0.08 | 0.17 | 0.29 | 0.25 | 0.07 | 0.13 | 0.24 | 0.20 | 0.25 | 0.22 | 0.18 | 0.15 | 0.13 | 0.29 | 0.87 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | Area | 0.00 | 0.00 | 0.00 | 0.01 | 0.07 | 0.19 | 0.32 | 0.23 | 0.09 | 0.09 | 0.21 | 0.23 | 0.23 | 0.22 | 0.19 | 0.19 | 0.22 | 0.29 | 0.91 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | Taint | 0.00 | 0.00 | 0.01 | 0.02 | 0.13 | 0.24 | 0.27 | 0.13 | 0.03 | 0.18 | 0.23 | 0.21 | 0.23 | 0.21 | 0.28 | 0.26 | 0.27 | 0.34 | 0.82 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | Scoped credit | 0.00 | 0.00 | 0.00 | 0.01 | 0.06 | 0.18 | 0.30 | 0.26 | 0.07 | 0.12 | 0.24 | 0.21 | 0.21 | 0.25 | 0.19 | 0.15 | 0.15 | 0.27 | 0.88 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | Provenance ignored | 0.00 | 0.00 | 0.00 | 0.03 | 0.12 | 0.25 | 0.25 | 0.15 | 0.03 | 0.17 | 0.22 | 0.23 | 0.21 | 0.21 | 0.27 | 0.23 | 0.26 | 0.38 | 0.83 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | Office | 0.00 | 0.00 | 0.00 | 0.01 | 0.10 | 0.25 | 0.29 | 0.23 | 0.06 | 0.07 | 0.24 | 0.25 | 0.23 | 0.45 | 0.18 | 0.18 | 0.19 | 0.27 | 0.93 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | Area | 0.00 | 0.00 | 0.00 | 0.03 | 0.10 | 0.24 | 0.31 | 0.22 | 0.05 | 0.04 | 0.24 | 0.22 | 0.24 | 0.51 | 0.17 | 0.20 | 0.25 | 0.30 | 0.96 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | Taint | 0.00 | 0.00 | 0.01 | 0.04 | 0.14 | 0.26 | 0.28 | 0.14 | 0.03 | 0.12 | 0.21 | 0.22 | 0.25 | 0.38 | 0.25 | 0.29 | 0.25 | 0.41 | 0.88 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | Scoped credit | 0.00 | 0.00 | 0.00 | 0.02 | 0.09 | 0.21 | 0.33 | 0.22 | 0.07 | 0.05 | 0.23 | 0.26 | 0.23 | 0.48 | 0.20 | 0.15 | 0.17 | 0.30 | 0.95 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | Provenance ignored | 0.00 | 0.00 | 0.00 | 0.05 | 0.13 | 0.26 | 0.27 | 0.11 | 0.05 | 0.12 | 0.24 | 0.23 | 0.19 | 0.34 | 0.26 | 0.29 | 0.29 | 0.37 | 0.88 | 0.00 | 0.00 | 0.00 |
| bound0 | 140 | Office, G at the bound (AI 0.20 vs hand-made 0.10) | 0.00 | 0.00 | 0.00 | 0.01 | 0.08 | 0.22 | 0.28 | 0.24 | 0.08 | 0.09 | 0.23 | 0.23 | 0.20 | 0.23 | 0.24 | 0.22 | 0.14 | 0.33 | 0.91 | 0.00 | 0.00 | 0.00 |
| bound1 | 140 | Office, G at the bound (AI 0.20 vs hand-made 0.10) | 0.00 | 0.00 | 0.00 | 0.03 | 0.08 | 0.24 | 0.32 | 0.18 | 0.07 | 0.08 | 0.23 | 0.19 | 0.19 | 0.48 | 0.24 | 0.22 | 0.12 | 0.33 | 0.92 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0.00 | 0.00 | 0.00 | 0.03 | 0.10 | 0.25 | 0.30 | 0.19 | 0.05 | 0.07 | 0.25 | 0.22 | 0.26 | 0.24 | 0.26 | 0.24 | 0.21 | 0.43 | 0.93 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.25 | 0.00 | 0.00 | 0.00 | 0.03 | 0.11 | 0.25 | 0.30 | 0.20 | 0.06 | 0.06 | 0.24 | 0.26 | 0.23 | 0.25 | 0.28 | 0.23 | 0.21 | 0.43 | 0.94 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0.00 | 0.00 | 0.00 | 0.03 | 0.12 | 0.27 | 0.31 | 0.16 | 0.04 | 0.07 | 0.24 | 0.26 | 0.26 | 0.25 | 0.30 | 0.29 | 0.21 | 0.40 | 0.93 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0.00 | 0.00 | 0.00 | 0.01 | 0.05 | 0.18 | 0.31 | 0.24 | 0.09 | 0.12 | 0.19 | 0.22 | 0.21 | 0.23 | 0.23 | 0.15 | 0.11 | 0.31 | 0.88 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.50 | 0.00 | 0.00 | 0.00 | 0.01 | 0.06 | 0.19 | 0.30 | 0.25 | 0.10 | 0.09 | 0.23 | 0.21 | 0.22 | 0.24 | 0.19 | 0.17 | 0.11 | 0.30 | 0.91 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0.00 | 0.00 | 0.00 | 0.01 | 0.07 | 0.19 | 0.29 | 0.24 | 0.07 | 0.13 | 0.22 | 0.22 | 0.23 | 0.22 | 0.22 | 0.19 | 0.13 | 0.29 | 0.87 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0.00 | 0.00 | 0.01 | 0.05 | 0.15 | 0.28 | 0.30 | 0.15 | 0.02 | 0.04 | 0.27 | 0.24 | 0.27 | 0.55 | 0.27 | 0.25 | 0.22 | 0.42 | 0.96 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0.00 | 0.00 | 0.00 | 0.04 | 0.15 | 0.33 | 0.27 | 0.13 | 0.03 | 0.05 | 0.27 | 0.24 | 0.28 | 0.51 | 0.29 | 0.27 | 0.20 | 0.40 | 0.95 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0.00 | 0.00 | 0.00 | 0.01 | 0.08 | 0.22 | 0.32 | 0.23 | 0.07 | 0.07 | 0.23 | 0.22 | 0.22 | 0.44 | 0.22 | 0.18 | 0.13 | 0.30 | 0.93 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0.00 | 0.00 | 0.00 | 0.02 | 0.07 | 0.25 | 0.31 | 0.21 | 0.06 | 0.07 | 0.21 | 0.25 | 0.23 | 0.43 | 0.25 | 0.19 | 0.12 | 0.32 | 0.93 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0.00 | 0.00 | 0.01 | 0.02 | 0.14 | 0.23 | 0.32 | 0.16 | 0.05 | 0.07 | 0.24 | 0.23 | 0.26 | 0.26 | 0.30 | 0.26 | 0.22 | 0.43 | 0.93 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.25 | 0.00 | 0.00 | 0.01 | 0.02 | 0.11 | 0.24 | 0.28 | 0.20 | 0.05 | 0.09 | 0.22 | 0.24 | 0.23 | 0.22 | 0.27 | 0.26 | 0.22 | 0.39 | 0.91 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0.00 | 0.00 | 0.00 | 0.02 | 0.10 | 0.30 | 0.25 | 0.18 | 0.04 | 0.09 | 0.24 | 0.23 | 0.22 | 0.25 | 0.30 | 0.26 | 0.24 | 0.39 | 0.91 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0.00 | 0.00 | 0.00 | 0.01 | 0.08 | 0.15 | 0.31 | 0.23 | 0.10 | 0.12 | 0.20 | 0.21 | 0.22 | 0.22 | 0.20 | 0.18 | 0.12 | 0.34 | 0.88 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.50 | 0.00 | 0.00 | 0.00 | 0.01 | 0.07 | 0.19 | 0.28 | 0.23 | 0.08 | 0.15 | 0.22 | 0.22 | 0.24 | 0.19 | 0.21 | 0.14 | 0.15 | 0.30 | 0.85 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0.00 | 0.00 | 0.00 | 0.01 | 0.05 | 0.17 | 0.31 | 0.21 | 0.07 | 0.17 | 0.21 | 0.22 | 0.19 | 0.20 | 0.20 | 0.20 | 0.13 | 0.27 | 0.83 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0.00 | 0.00 | 0.00 | 0.05 | 0.15 | 0.25 | 0.31 | 0.17 | 0.03 | 0.05 | 0.23 | 0.21 | 0.27 | 0.48 | 0.28 | 0.27 | 0.22 | 0.42 | 0.95 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0.00 | 0.00 | 0.01 | 0.04 | 0.18 | 0.27 | 0.26 | 0.16 | 0.04 | 0.04 | 0.24 | 0.27 | 0.22 | 0.48 | 0.28 | 0.32 | 0.23 | 0.38 | 0.96 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0.00 | 0.00 | 0.00 | 0.01 | 0.09 | 0.21 | 0.29 | 0.24 | 0.07 | 0.09 | 0.22 | 0.22 | 0.23 | 0.39 | 0.22 | 0.17 | 0.14 | 0.32 | 0.91 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0.00 | 0.00 | 0.01 | 0.02 | 0.07 | 0.22 | 0.30 | 0.20 | 0.08 | 0.10 | 0.21 | 0.21 | 0.24 | 0.42 | 0.21 | 0.20 | 0.13 | 0.28 | 0.90 | 0.00 | 0.00 | 0.00 |

By setting, instrument check (own values and failing value pooled):

| setting | N | generating | IC_removed_0 | IC_removed_1 | IC_removed_2 | IC_removed_3 | IC_kept_scene_blk | IC_kept_scene_src | IC_kept_scene_intercept | IC_removals_after_convergence_failure | IC_accepted_with_gradient_warning | IC_fit_failed |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| main0 | 140 | Office | 0.06 | 0.26 | 0.39 | 0.29 | 0.18 | 0.19 | 0.71 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | Area | 0.06 | 0.29 | 0.49 | 0.16 | 0.22 | 0.20 | 0.84 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | Taint | 0.05 | 0.26 | 0.37 | 0.32 | 0.16 | 0.20 | 0.68 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | Scoped credit | 0.05 | 0.26 | 0.40 | 0.29 | 0.17 | 0.19 | 0.71 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | Provenance ignored | 0.05 | 0.24 | 0.36 | 0.34 | 0.17 | 0.18 | 0.66 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | Office | 0.08 | 0.35 | 0.37 | 0.21 | 0.20 | 0.30 | 0.79 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | Area | 0.11 | 0.40 | 0.38 | 0.10 | 0.23 | 0.39 | 0.90 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | Taint | 0.08 | 0.31 | 0.33 | 0.29 | 0.20 | 0.26 | 0.71 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | Scoped credit | 0.09 | 0.34 | 0.38 | 0.19 | 0.21 | 0.30 | 0.81 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | Provenance ignored | 0.07 | 0.30 | 0.33 | 0.30 | 0.18 | 0.27 | 0.70 | 0.00 | 0.00 | 0.00 |
| sens15 | 140 | Office | 0.04 | 0.25 | 0.33 | 0.38 | 0.18 | 0.16 | 0.62 | 0.00 | 0.00 | 0.00 |
| sens15 | 140 | Area | 0.07 | 0.27 | 0.42 | 0.24 | 0.19 | 0.21 | 0.76 | 0.00 | 0.00 | 0.00 |
| sens15 | 140 | Taint | 0.04 | 0.21 | 0.34 | 0.42 | 0.14 | 0.14 | 0.58 | 0.00 | 0.00 | 0.00 |
| sens15 | 140 | Scoped credit | 0.04 | 0.25 | 0.36 | 0.35 | 0.17 | 0.15 | 0.65 | 0.00 | 0.00 | 0.00 |
| sens15 | 140 | Provenance ignored | 0.03 | 0.23 | 0.33 | 0.41 | 0.14 | 0.16 | 0.59 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | Office | 0.04 | 0.26 | 0.41 | 0.29 | 0.17 | 0.18 | 0.71 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | Area | 0.05 | 0.32 | 0.41 | 0.22 | 0.19 | 0.23 | 0.78 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | Taint | 0.04 | 0.24 | 0.34 | 0.38 | 0.15 | 0.17 | 0.62 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | Scoped credit | 0.04 | 0.26 | 0.41 | 0.29 | 0.16 | 0.19 | 0.71 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | Provenance ignored | 0.04 | 0.23 | 0.36 | 0.36 | 0.16 | 0.16 | 0.64 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | Office | 0.08 | 0.29 | 0.39 | 0.24 | 0.18 | 0.27 | 0.75 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | Area | 0.10 | 0.39 | 0.38 | 0.13 | 0.24 | 0.36 | 0.87 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | Taint | 0.05 | 0.30 | 0.33 | 0.33 | 0.16 | 0.24 | 0.67 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | Scoped credit | 0.06 | 0.31 | 0.37 | 0.25 | 0.18 | 0.26 | 0.75 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | Provenance ignored | 0.07 | 0.28 | 0.34 | 0.31 | 0.17 | 0.25 | 0.69 | 0.00 | 0.00 | 0.00 |
| bound0 | 140 | Office, G at the bound (AI 0.20 vs hand-made 0.10) | 0.05 | 0.27 | 0.38 | 0.30 | 0.18 | 0.20 | 0.70 | 0.00 | 0.00 | 0.00 |
| bound1 | 140 | Office, G at the bound (AI 0.20 vs hand-made 0.10) | 0.07 | 0.36 | 0.32 | 0.25 | 0.20 | 0.30 | 0.75 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0.07 | 0.31 | 0.40 | 0.23 | 0.22 | 0.22 | 0.77 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.25 | 0.06 | 0.31 | 0.40 | 0.22 | 0.23 | 0.21 | 0.78 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0.07 | 0.30 | 0.39 | 0.24 | 0.22 | 0.22 | 0.76 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0.05 | 0.23 | 0.40 | 0.33 | 0.15 | 0.17 | 0.67 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.50 | 0.04 | 0.26 | 0.42 | 0.29 | 0.18 | 0.16 | 0.71 | 0.00 | 0.00 | 0.00 |
| main0 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0.04 | 0.23 | 0.40 | 0.34 | 0.15 | 0.15 | 0.66 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0.11 | 0.40 | 0.33 | 0.17 | 0.24 | 0.38 | 0.83 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0.12 | 0.37 | 0.32 | 0.18 | 0.25 | 0.37 | 0.82 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0.07 | 0.33 | 0.37 | 0.24 | 0.18 | 0.28 | 0.76 | 0.00 | 0.00 | 0.00 |
| main1 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0.07 | 0.31 | 0.38 | 0.25 | 0.18 | 0.26 | 0.75 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0.06 | 0.27 | 0.42 | 0.24 | 0.19 | 0.20 | 0.76 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.25 | 0.06 | 0.29 | 0.39 | 0.26 | 0.20 | 0.21 | 0.74 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0.06 | 0.28 | 0.37 | 0.29 | 0.19 | 0.20 | 0.71 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0.04 | 0.22 | 0.39 | 0.35 | 0.13 | 0.17 | 0.65 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.50 | 0.03 | 0.23 | 0.37 | 0.36 | 0.14 | 0.16 | 0.63 | 0.00 | 0.00 | 0.00 |
| fall0 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0.04 | 0.22 | 0.36 | 0.37 | 0.14 | 0.18 | 0.63 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0.11 | 0.36 | 0.35 | 0.18 | 0.24 | 0.34 | 0.82 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0.10 | 0.37 | 0.31 | 0.23 | 0.22 | 0.35 | 0.77 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0.05 | 0.29 | 0.39 | 0.27 | 0.18 | 0.22 | 0.73 | 0.00 | 0.00 | 0.00 |
| fall1 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0.06 | 0.30 | 0.35 | 0.29 | 0.16 | 0.26 | 0.70 | 0.00 | 0.00 | 0.00 |

## Full results

Scope family:

| setting | N | generating | n_datasets | own_rate | max_rival | support_scoped_credit | support_taint | support_provenance_ignored | S1_true | S1_zero | S1_positive | S1_negative | S1_undetermined | S1_mean_est | S1_mean_se | S2_true | S2_zero | S2_positive | S2_negative | S2_undetermined | S2_mean_est | S2_mean_se | sec_per_fit |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| main0 | 140 | Scoped credit, the Office's premise Q1, or a literal reading of each item | 1,000 | 0.96 | 0.01 | 0.96 | 0.01 | 0.00 | 0.34 | 0.00 | 1.00 | 0.00 | 0.00 | 0.33 | 0.07 | 0.00 | 0.96 | 0.01 | 0.01 | 0.01 | 0.00 | 0.06 | 5.00 |
| main0 | 140 | Taint, at any strength | 1,000 | 0.93 | 0.00 | 0.00 | 0.93 | 0.00 | 0.00 | 0.91 | 0.02 | 0.03 | 0.04 | -0.00 | 0.07 | 0.34 | 0.00 | 1.00 | 0.00 | 0.00 | 0.34 | 0.06 | 5.10 |
| main0 | 140 | Provenance ignored | 1,000 | 0.88 | 0.02 | 0.02 | 0.01 | 0.88 | 0.00 | 0.91 | 0.02 | 0.03 | 0.04 | -0.00 | 0.07 | 0.00 | 0.96 | 0.01 | 0.01 | 0.01 | 0.00 | 0.06 | 4.82 |
| main0 | 140 | S2 residue 0.10 | 500 |  |  | 0.63 | 0.34 | 0.00 | 0.34 | 0.00 | 1.00 | 0.00 | 0.00 | 0.33 | 0.07 | 0.10 | 0.63 | 0.34 | 0.00 | 0.03 | 0.10 | 0.06 | 4.14 |
| main0 | 140 | S2 residue 0.15 | 500 |  |  | 0.31 | 0.66 | 0.00 | 0.34 | 0.00 | 1.00 | 0.00 | 0.00 | 0.33 | 0.07 | 0.15 | 0.31 | 0.66 | 0.00 | 0.03 | 0.15 | 0.06 | 4.15 |
| main1 | 140 | Scoped credit, the Office's premise Q1, or a literal reading of each item | 1,000 | 0.83 | 0.02 | 0.83 | 0.02 | 0.00 | 0.34 | 0.00 | 1.00 | 0.00 | 0.00 | 0.34 | 0.07 | 0.00 | 0.83 | 0.02 | 0.02 | 0.13 | -0.00 | 0.07 | 4.58 |
| main1 | 140 | Taint, at any strength | 1,000 | 0.92 | 0.00 | 0.00 | 0.92 | 0.00 | 0.00 | 0.91 | 0.03 | 0.02 | 0.05 | -0.00 | 0.07 | 0.34 | 0.00 | 0.99 | 0.00 | 0.01 | 0.34 | 0.07 | 4.38 |
| main1 | 140 | Provenance ignored | 1,000 | 0.77 | 0.02 | 0.02 | 0.01 | 0.77 | 0.00 | 0.91 | 0.03 | 0.02 | 0.05 | -0.00 | 0.07 | 0.00 | 0.83 | 0.02 | 0.02 | 0.13 | -0.00 | 0.07 | 4.41 |
| main1 | 140 | S2 residue 0.10 | 500 |  |  | 0.49 | 0.26 | 0.00 | 0.34 | 0.00 | 1.00 | 0.00 | 0.00 | 0.33 | 0.07 | 0.10 | 0.49 | 0.26 | 0.00 | 0.25 | 0.10 | 0.07 | 4.58 |
| main1 | 140 | S2 residue 0.15 | 500 |  |  | 0.26 | 0.52 | 0.00 | 0.34 | 0.00 | 1.00 | 0.00 | 0.00 | 0.33 | 0.07 | 0.15 | 0.26 | 0.52 | 0.00 | 0.21 | 0.15 | 0.07 | 4.62 |
| bound0 | 140 | Scoped credit, the Office's premise Q1, or a literal reading of each item | 500 | 0.89 | 0.04 | 0.89 | 0.01 | 0.04 | 0.22 | 0.05 | 0.91 | 0.00 | 0.04 | 0.22 | 0.07 | 0.00 | 0.97 | 0.01 | 0.01 | 0.01 | 0.00 | 0.06 | 5.42 |
| bound0 | 140 | Taint, at any strength | 500 | 0.88 | 0.03 | 0.01 | 0.88 | 0.03 | 0.00 | 0.90 | 0.03 | 0.03 | 0.04 | -0.00 | 0.07 | 0.22 | 0.04 | 0.95 | 0.00 | 0.01 | 0.22 | 0.06 | 5.29 |
| bound0 | 140 | Provenance ignored | 500 | 0.88 | 0.03 | 0.03 | 0.00 | 0.88 | 0.00 | 0.90 | 0.03 | 0.03 | 0.04 | -0.00 | 0.07 | 0.00 | 0.97 | 0.01 | 0.01 | 0.01 | 0.00 | 0.06 | 5.27 |
| bound1 | 140 | Scoped credit, the Office's premise Q1, or a literal reading of each item | 500 | 0.76 | 0.04 | 0.76 | 0.02 | 0.04 | 0.22 | 0.06 | 0.90 | 0.00 | 0.04 | 0.22 | 0.07 | 0.00 | 0.83 | 0.02 | 0.01 | 0.13 | 0.00 | 0.07 | 4.43 |
| bound1 | 140 | Taint, at any strength | 500 | 0.76 | 0.03 | 0.00 | 0.76 | 0.03 | 0.00 | 0.89 | 0.02 | 0.02 | 0.07 | -0.00 | 0.07 | 0.22 | 0.04 | 0.84 | 0.00 | 0.12 | 0.22 | 0.07 | 4.22 |
| bound1 | 140 | Provenance ignored | 500 | 0.75 | 0.02 | 0.01 | 0.02 | 0.75 | 0.00 | 0.89 | 0.02 | 0.02 | 0.07 | -0.00 | 0.07 | 0.00 | 0.83 | 0.02 | 0.01 | 0.13 | 0.00 | 0.07 | 4.26 |
| sens15 | 140 | Scoped credit, the Office's premise Q1, or a literal reading of each item | 500 | 0.74 | 0.02 | 0.74 | 0.02 | 0.00 | 0.34 | 0.00 | 1.00 | 0.00 | 0.00 | 0.33 | 0.07 | 0.00 | 0.74 | 0.02 | 0.03 | 0.20 | -0.00 | 0.08 | 4.54 |
| sens15 | 140 | Taint, at any strength | 500 | 0.90 | 0.00 | 0.00 | 0.90 | 0.00 | 0.00 | 0.90 | 0.03 | 0.03 | 0.04 | -0.00 | 0.07 | 0.34 | 0.00 | 0.98 | 0.00 | 0.02 | 0.33 | 0.08 | 4.39 |
| sens15 | 140 | Provenance ignored | 500 | 0.68 | 0.02 | 0.02 | 0.01 | 0.68 | 0.00 | 0.90 | 0.03 | 0.03 | 0.04 | -0.00 | 0.07 | 0.00 | 0.74 | 0.02 | 0.03 | 0.20 | -0.00 | 0.08 | 4.45 |
| fall0 | 120 | Scoped credit, the Office's premise Q1, or a literal reading of each item | 500 | 0.94 | 0.02 | 0.94 | 0.02 | 0.00 | 0.34 | 0.00 | 1.00 | 0.00 | 0.00 | 0.34 | 0.07 | 0.00 | 0.95 | 0.02 | 0.01 | 0.03 | 0.00 | 0.06 | 4.14 |
| fall0 | 120 | Taint, at any strength | 500 | 0.84 | 0.00 | 0.00 | 0.84 | 0.00 | 0.00 | 0.82 | 0.02 | 0.02 | 0.14 | 0.00 | 0.07 | 0.34 | 0.00 | 1.00 | 0.00 | 0.00 | 0.34 | 0.06 | 3.90 |
| fall0 | 120 | Provenance ignored | 500 | 0.79 | 0.02 | 0.02 | 0.01 | 0.79 | 0.00 | 0.82 | 0.02 | 0.02 | 0.14 | 0.00 | 0.07 | 0.00 | 0.95 | 0.02 | 0.01 | 0.03 | 0.00 | 0.06 | 3.93 |
| fall1 | 120 | Scoped credit, the Office's premise Q1, or a literal reading of each item | 500 | 0.78 | 0.03 | 0.78 | 0.03 | 0.00 | 0.34 | 0.00 | 1.00 | 0.00 | 0.00 | 0.33 | 0.07 | 0.00 | 0.78 | 0.03 | 0.03 | 0.17 | -0.00 | 0.07 | 3.64 |
| fall1 | 120 | Taint, at any strength | 500 | 0.86 | 0.00 | 0.00 | 0.86 | 0.00 | 0.00 | 0.84 | 0.02 | 0.02 | 0.11 | -0.00 | 0.07 | 0.34 | 0.00 | 0.99 | 0.00 | 0.01 | 0.33 | 0.07 | 3.51 |
| fall1 | 120 | Provenance ignored | 500 | 0.68 | 0.02 | 0.01 | 0.02 | 0.68 | 0.00 | 0.84 | 0.02 | 0.02 | 0.11 | -0.00 | 0.07 | 0.00 | 0.78 | 0.03 | 0.03 | 0.17 | -0.00 | 0.07 | 3.55 |

Gate G and the instrument check (IC: under the setting's own block-2 values; ICf: with the failing value):

| family | setting | N | generating | nAGQ | n_datasets | true_G | G_pass | G_mean_est | G_mean_se | true_IC | IC_usable | IC_mean_est | IC_mean_upper | ICf_usable | ICf_mean_est | ICf_mean_upper | sec_per_dataset |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| G (specification pattern) | main0 | 140 | Office | 0 | 1,000 | 0.50 | 1.00 | 0.47 | 0.05 | 0.75 | 1.00 | 0.72 | 0.80 | 0.24 | 0.23 | 0.31 | 74.34 |
| G (specification pattern) | main0 | 140 | Area | 0 | 1,000 | 0.00 | 0.01 | 0.00 | 0.05 | 0.60 | 1.00 | 0.59 | 0.67 | 0.18 | 0.23 | 0.30 | 9.97 |
| G (specification pattern) | main0 | 140 | Taint | 0 | 1,000 | 0.00 | 0.01 | 0.00 | 0.04 | 0.10 | 0.00 | 0.13 | 0.19 | 0.31 | 0.24 | 0.31 | 8.61 |
| G (specification pattern) | main0 | 140 | Scoped credit | 0 | 1,000 | 0.50 | 1.00 | 0.47 | 0.05 | 0.60 | 1.00 | 0.59 | 0.67 | 0.24 | 0.23 | 0.30 | 8.49 |
| G (specification pattern) | main0 | 140 | Provenance ignored | 0 | 1,000 | 0.00 | 0.00 | 0.00 | 0.04 | 0.10 | 0.00 | 0.13 | 0.20 | 0.34 | 0.24 | 0.32 | 58.98 |
| G (specification pattern) | main1 | 140 | Office | 0 | 1,000 | 0.50 | 1.00 | 0.47 | 0.05 | 0.75 | 1.00 | 0.72 | 0.80 | 0.29 | 0.23 | 0.31 | 8.48 |
| G (specification pattern) | main1 | 140 | Area | 0 | 1,000 | 0.00 | 0.02 | -0.00 | 0.05 | 0.60 | 1.00 | 0.59 | 0.68 | 0.21 | 0.22 | 0.30 | 8.79 |
| G (specification pattern) | main1 | 140 | Taint | 0 | 1,000 | 0.00 | 0.00 | -0.00 | 0.04 | 0.10 | 0.00 | 0.13 | 0.20 | 0.35 | 0.24 | 0.32 | 8.15 |
| G (specification pattern) | main1 | 140 | Scoped credit | 0 | 1,000 | 0.50 | 1.00 | 0.47 | 0.05 | 0.60 | 1.00 | 0.59 | 0.68 | 0.31 | 0.23 | 0.31 | 8.06 |
| G (specification pattern) | main1 | 140 | Provenance ignored | 0 | 1,000 | 0.00 | 0.00 | -0.00 | 0.04 | 0.10 | 0.00 | 0.13 | 0.19 | 0.32 | 0.24 | 0.31 | 8.22 |
| G (specification pattern) | sens15 | 140 | Office | 0 | 500 | 0.50 | 1.00 | 0.46 | 0.05 | 0.75 | 1.00 | 0.72 | 0.80 | 0.24 | 0.23 | 0.30 | 8.60 |
| G (specification pattern) | sens15 | 140 | Area | 0 | 500 | 0.00 | 0.01 | -0.00 | 0.05 | 0.60 | 1.00 | 0.59 | 0.67 | 0.15 | 0.23 | 0.30 | 9.46 |
| G (specification pattern) | sens15 | 140 | Taint | 0 | 500 | 0.00 | 0.00 | 0.00 | 0.04 | 0.10 | 0.00 | 0.14 | 0.20 | 0.32 | 0.24 | 0.31 | 9.20 |
| G (specification pattern) | sens15 | 140 | Scoped credit | 0 | 500 | 0.50 | 1.00 | 0.47 | 0.05 | 0.60 | 1.00 | 0.59 | 0.68 | 0.29 | 0.24 | 0.31 | 8.68 |
| G (specification pattern) | sens15 | 140 | Provenance ignored | 0 | 500 | 0.00 | 0.01 | 0.00 | 0.04 | 0.10 | 0.00 | 0.14 | 0.20 | 0.33 | 0.24 | 0.32 | 8.74 |
| G (specification pattern) | fall0 | 120 | Office | 0 | 500 | 0.50 | 1.00 | 0.47 | 0.05 | 0.75 | 1.00 | 0.72 | 0.81 | 0.35 | 0.24 | 0.32 | 6.57 |
| G (specification pattern) | fall0 | 120 | Area | 0 | 500 | 0.00 | 0.02 | -0.00 | 0.05 | 0.60 | 1.00 | 0.59 | 0.68 | 0.26 | 0.23 | 0.30 | 7.09 |
| G (specification pattern) | fall0 | 120 | Taint | 0 | 500 | 0.00 | 0.00 | -0.00 | 0.04 | 0.10 | 0.00 | 0.13 | 0.20 | 0.38 | 0.24 | 0.32 | 7.20 |
| G (specification pattern) | fall0 | 120 | Scoped credit | 0 | 500 | 0.50 | 1.00 | 0.47 | 0.05 | 0.60 | 1.00 | 0.59 | 0.68 | 0.32 | 0.23 | 0.31 | 6.65 |
| G (specification pattern) | fall0 | 120 | Provenance ignored | 0 | 500 | 0.00 | 0.00 | -0.00 | 0.04 | 0.10 | 0.00 | 0.13 | 0.20 | 0.38 | 0.24 | 0.32 | 6.89 |
| G (specification pattern) | fall1 | 120 | Office | 0 | 500 | 0.50 | 1.00 | 0.46 | 0.05 | 0.75 | 1.00 | 0.72 | 0.81 | 0.29 | 0.23 | 0.31 | 6.65 |
| G (specification pattern) | fall1 | 120 | Area | 0 | 500 | 0.00 | 0.03 | 0.00 | 0.05 | 0.60 | 1.00 | 0.59 | 0.68 | 0.27 | 0.23 | 0.31 | 7.11 |
| G (specification pattern) | fall1 | 120 | Taint | 0 | 500 | 0.00 | 0.00 | -0.00 | 0.04 | 0.10 | 0.00 | 0.13 | 0.20 | 0.38 | 0.24 | 0.32 | 6.71 |
| G (specification pattern) | fall1 | 120 | Scoped credit | 0 | 500 | 0.50 | 1.00 | 0.47 | 0.05 | 0.60 | 1.00 | 0.59 | 0.68 | 0.31 | 0.23 | 0.31 | 6.63 |
| G (specification pattern) | fall1 | 120 | Provenance ignored | 0 | 500 | 0.00 | 0.01 | 0.00 | 0.04 | 0.10 | 0.00 | 0.13 | 0.20 | 0.40 | 0.24 | 0.32 | 6.73 |
| G (at the bound) | bound0 | 140 | Office, G at the bound (AI 0.20 vs hand-made 0.10) | 0 | 500 | 0.10 | 0.54 | 0.10 | 0.04 | 0.75 | 1.00 | 0.72 | 0.80 | 0.29 | 0.23 | 0.31 | 8.03 |
| G (at the bound) | bound1 | 140 | Office, G at the bound (AI 0.20 vs hand-made 0.10) | 0 | 500 | 0.10 | 0.57 | 0.11 | 0.04 | 0.75 | 1.00 | 0.72 | 0.80 | 0.32 | 0.24 | 0.31 | 8.16 |
| G (planning scenario) | main0 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0 | 1,000 | 0.15 | 0.84 | 0.15 | 0.05 | 0.75 | 1.00 | 0.73 | 0.81 | 0.20 | 0.22 | 0.30 | 7.59 |
| G (planning scenario) | main0 | 140 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.25 | 0 | 1,000 | 0.25 | 1.00 | 0.24 | 0.05 | 0.75 | 1.00 | 0.73 | 0.81 | 0.22 | 0.22 | 0.30 | 7.71 |
| G (planning scenario) | main0 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0 | 1,000 | 0.00 | 0.01 | -0.00 | 0.04 | 0.75 | 1.00 | 0.72 | 0.80 | 0.22 | 0.23 | 0.30 | 7.63 |
| G (planning scenario) | main0 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0 | 1,000 | 0.15 | 0.90 | 0.15 | 0.04 | 0.75 | 1.00 | 0.72 | 0.80 | 0.32 | 0.24 | 0.31 | 8.89 |
| G (planning scenario) | main0 | 140 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.50 | 0 | 1,000 | 0.25 | 1.00 | 0.24 | 0.04 | 0.75 | 1.00 | 0.72 | 0.80 | 0.30 | 0.24 | 0.31 | 8.86 |
| G (planning scenario) | main0 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0 | 1,000 | 0.00 | 0.01 | -0.00 | 0.04 | 0.75 | 1.00 | 0.72 | 0.80 | 0.36 | 0.24 | 0.32 | 9.13 |
| G (planning scenario) | main1 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0 | 1,000 | 0.15 | 0.85 | 0.15 | 0.05 | 0.75 | 1.00 | 0.73 | 0.81 | 0.25 | 0.23 | 0.30 | 7.55 |
| G (planning scenario) | main1 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0 | 1,000 | 0.00 | 0.01 | -0.00 | 0.04 | 0.75 | 1.00 | 0.73 | 0.81 | 0.27 | 0.23 | 0.30 | 7.58 |
| G (planning scenario) | main1 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0 | 1,000 | 0.15 | 0.86 | 0.15 | 0.04 | 0.75 | 1.00 | 0.72 | 0.80 | 0.34 | 0.24 | 0.32 | 9.23 |
| G (planning scenario) | main1 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0 | 1,000 | 0.00 | 0.01 | -0.00 | 0.04 | 0.75 | 1.00 | 0.72 | 0.80 | 0.39 | 0.24 | 0.32 | 9.05 |
| G (planning scenario) | fall0 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0 | 500 | 0.15 | 0.81 | 0.15 | 0.05 | 0.75 | 1.00 | 0.73 | 0.81 | 0.23 | 0.22 | 0.30 | 6.44 |
| G (planning scenario) | fall0 | 120 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.25 | 0 | 500 | 0.25 | 1.00 | 0.24 | 0.05 | 0.75 | 1.00 | 0.73 | 0.81 | 0.25 | 0.22 | 0.30 | 6.28 |
| G (planning scenario) | fall0 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0 | 500 | 0.00 | 0.02 | 0.00 | 0.05 | 0.75 | 1.00 | 0.73 | 0.81 | 0.27 | 0.22 | 0.31 | 6.38 |
| G (planning scenario) | fall0 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0 | 500 | 0.15 | 0.88 | 0.15 | 0.05 | 0.75 | 1.00 | 0.72 | 0.80 | 0.35 | 0.24 | 0.32 | 7.61 |
| G (planning scenario) | fall0 | 120 | P(divided \| AI) 0.40 vs hand-made 0.15, ICC 0.50 | 0 | 500 | 0.25 | 1.00 | 0.24 | 0.05 | 0.75 | 1.00 | 0.72 | 0.81 | 0.35 | 0.24 | 0.32 | 7.55 |
| G (planning scenario) | fall0 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0 | 500 | 0.00 | 0.01 | -0.00 | 0.04 | 0.75 | 1.00 | 0.72 | 0.80 | 0.41 | 0.24 | 0.32 | 7.68 |
| G (planning scenario) | fall1 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0 | 500 | 0.15 | 0.82 | 0.14 | 0.05 | 0.75 | 1.00 | 0.73 | 0.81 | 0.27 | 0.22 | 0.31 | 6.36 |
| G (planning scenario) | fall1 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0 | 500 | 0.00 | 0.01 | 0.00 | 0.05 | 0.75 | 1.00 | 0.73 | 0.81 | 0.27 | 0.22 | 0.30 | 6.44 |
| G (planning scenario) | fall1 | 120 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0 | 500 | 0.15 | 0.84 | 0.15 | 0.05 | 0.75 | 1.00 | 0.72 | 0.80 | 0.39 | 0.24 | 0.32 | 7.75 |
| G (planning scenario) | fall1 | 120 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0 | 500 | 0.00 | 0.01 | 0.00 | 0.04 | 0.75 | 1.00 | 0.72 | 0.80 | 0.44 | 0.24 | 0.33 | 7.50 |
| G and instrument check (Laplace check) | main0 | 140 | Office | 0 | 200 | 0.50 | 1.00 | 0.47 | 0.05 | 0.75 | 1.00 | 0.72 | 0.80 | 0.20 | 0.23 | 0.30 |  |
| G and instrument check (Laplace check) | main0 | 140 | Office | 1 | 200 | 0.50 | 1.00 | 0.51 | 0.05 | 0.75 | 1.00 | 0.75 | 0.84 | 0.04 | 0.19 | 0.27 | 41.71 |
| G and instrument check (Laplace check) | main0 | 140 | Area | 0 | 200 | 0.00 | 0.02 | -0.00 | 0.05 | 0.60 | 1.00 | 0.59 | 0.67 | 0.21 | 0.23 | 0.30 |  |
| G and instrument check (Laplace check) | main0 | 140 | Area | 1 | 200 | 0.00 | 0.04 | -0.00 | 0.05 | 0.60 | 1.00 | 0.60 | 0.69 | 0.10 | 0.20 | 0.27 | 24.94 |
| G and instrument check (Laplace check) | main0 | 140 | Taint | 0 | 200 | 0.00 | 0.01 | 0.01 | 0.04 | 0.10 | 0.00 | 0.13 | 0.19 | 0.27 | 0.23 | 0.31 |  |
| G and instrument check (Laplace check) | main0 | 140 | Taint | 1 | 200 | 0.00 | 0.00 | 0.00 | 0.03 | 0.10 | 0.00 | 0.10 | 0.17 | 0.07 | 0.19 | 0.27 | 671.95 |
| G and instrument check (Laplace check) | main0 | 140 | Scoped credit | 0 | 200 | 0.50 | 1.00 | 0.47 | 0.05 | 0.60 | 1.00 | 0.59 | 0.67 | 0.23 | 0.23 | 0.30 |  |
| G and instrument check (Laplace check) | main0 | 140 | Scoped credit | 1 | 200 | 0.50 | 1.00 | 0.51 | 0.05 | 0.60 | 1.00 | 0.60 | 0.69 | 0.07 | 0.19 | 0.27 | 346.03 |
| G and instrument check (Laplace check) | main0 | 140 | Provenance ignored | 0 | 200 | 0.00 | 0.00 | 0.00 | 0.04 | 0.10 | 0.00 | 0.14 | 0.20 | 0.32 | 0.24 | 0.32 |  |
| G and instrument check (Laplace check) | main0 | 140 | Provenance ignored | 1 | 200 | 0.00 | 0.00 | 0.00 | 0.03 | 0.10 | 0.00 | 0.10 | 0.17 | 0.07 | 0.19 | 0.28 | 737.59 |
| G and instrument check (Laplace check) | main0 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0 | 200 | 0.15 | 0.82 | 0.14 | 0.05 | 0.75 |  |  |  |  |  |  |  |
| G and instrument check (Laplace check) | main0 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 1 | 200 | 0.15 | 0.84 | 0.14 | 0.04 | 0.75 |  |  |  |  |  |  | 29.15 |
| G and instrument check (Laplace check) | main0 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0 | 200 | 0.00 | 0.01 | -0.00 | 0.04 | 0.75 |  |  |  |  |  |  |  |
| G and instrument check (Laplace check) | main0 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 1 | 200 | 0.00 | 0.01 | 0.00 | 0.04 | 0.75 |  |  |  |  |  |  | 36.38 |
| G and instrument check (Laplace check) | main0 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0 | 200 | 0.15 | 0.88 | 0.15 | 0.04 | 0.75 |  |  |  |  |  |  |  |
| G and instrument check (Laplace check) | main0 | 140 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 1 | 200 | 0.15 | 0.91 | 0.15 | 0.04 | 0.75 |  |  |  |  |  |  | 47.14 |
| G and instrument check (Laplace check) | main0 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0 | 200 | 0.00 | 0.03 | -0.00 | 0.04 | 0.75 |  |  |  |  |  |  |  |
| G and instrument check (Laplace check) | main0 | 140 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 1 | 200 | 0.00 | 0.01 | 0.00 | 0.04 | 0.75 |  |  |  |  |  |  | 68.00 |

## Laplace check

The first 200 datasets of each main0 decision pattern and of the main0 planning scenarios at .30 and .15 against .15, refitted with nAGQ = 1 (Laplace, the registered fitting method) and set beside the nAGQ = 0 fits of the same datasets: G under every pattern and planning scenario, the instrument check under every pattern. Fitting settings and convergence rule as above; 0.10 of the Laplace fits of G ended with the participant intercept alone, and 0.00 of the accepted Laplace fits of G carried lme4's gradient warning.

| setting | generating | nAGQ | n_datasets | G_pass | G_mean_est | G_mean_se | IC_usable | IC_mean_upper | ICf_usable | ICf_mean_upper |
|---|---|---|---|---|---|---|---|---|---|---|
| main0 | Office | 0 | 200 | 1.00 | 0.47 | 0.05 | 1.00 | 0.80 | 0.20 | 0.30 |
| main0 | Office | 1 | 200 | 1.00 | 0.51 | 0.05 | 1.00 | 0.84 | 0.04 | 0.27 |
| main0 | Area | 0 | 200 | 0.02 | -0.00 | 0.05 | 1.00 | 0.67 | 0.21 | 0.30 |
| main0 | Area | 1 | 200 | 0.04 | -0.00 | 0.05 | 1.00 | 0.69 | 0.10 | 0.27 |
| main0 | Taint | 0 | 200 | 0.01 | 0.01 | 0.04 | 0.00 | 0.19 | 0.27 | 0.31 |
| main0 | Taint | 1 | 200 | 0.00 | 0.00 | 0.03 | 0.00 | 0.17 | 0.07 | 0.27 |
| main0 | Scoped credit | 0 | 200 | 1.00 | 0.47 | 0.05 | 1.00 | 0.67 | 0.23 | 0.30 |
| main0 | Scoped credit | 1 | 200 | 1.00 | 0.51 | 0.05 | 1.00 | 0.69 | 0.07 | 0.27 |
| main0 | Provenance ignored | 0 | 200 | 0.00 | 0.00 | 0.04 | 0.00 | 0.20 | 0.32 | 0.32 |
| main0 | Provenance ignored | 1 | 200 | 0.00 | 0.00 | 0.03 | 0.00 | 0.17 | 0.07 | 0.28 |
| main0 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 0 | 200 | 0.82 | 0.14 | 0.05 |  |  |  |  |
| main0 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.25 | 1 | 200 | 0.84 | 0.14 | 0.04 |  |  |  |  |
| main0 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 0 | 200 | 0.01 | -0.00 | 0.04 |  |  |  |  |
| main0 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.25 | 1 | 200 | 0.01 | 0.00 | 0.04 |  |  |  |  |
| main0 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 0 | 200 | 0.88 | 0.15 | 0.04 |  |  |  |  |
| main0 | P(divided \| AI) 0.30 vs hand-made 0.15, ICC 0.50 | 1 | 200 | 0.91 | 0.15 | 0.04 |  |  |  |  |
| main0 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 0 | 200 | 0.03 | -0.00 | 0.04 |  |  |  |  |
| main0 | P(divided \| AI) 0.15 vs hand-made 0.15, ICC 0.50 | 1 | 200 | 0.01 | 0.00 | 0.04 |  |  |  |  |

Mean difference, nAGQ = 0 minus Laplace estimate, on the same datasets: G -0.038 at Office; -0.000 at Area; 0.001 at Taint; -0.038 at Scoped credit; 0.000 at Provenance ignored; -0.003 at P(divided | AI) 0.30 vs hand-made 0.15, ICC 0.25; -0.001 at P(divided | AI) 0.15 vs hand-made 0.15, ICC 0.25; -0.002 at P(divided | AI) 0.30 vs hand-made 0.15, ICC 0.50; -0.001 at P(divided | AI) 0.15 vs hand-made 0.15, ICC 0.50; instrument check -0.034 at Office; -0.016 at Area; 0.034 at Taint; -0.014 at Scoped credit; 0.035 at Provenance ignored.

## Generating model

- Creativity (1.10 and plan_sim_v2.py): participant SD 0.62; participant-by-source SD 0.25 (12.1.8), shared by the two items; participant-by-item SD 0.25 added to the addition item only; scene SD 0.2; residual SD 0.7; scene-by-source deviations of SD 0 or 0.10, shared by the two items. No effects of amount or item order. Ratings are generated as normal and not rounded or clipped to 1-5, as in the planning simulation.
- Scope accounts: a contrast the account calls nonzero is set to 1.5 x bound (or the bound), else 0 (scoped credit S1 > 0, S2 = 0; taint S1 = 0, S2 > 0; provenance ignored both 0). The same noise is used for every account within a dataset.
- Decision: P(divided) per cell is population-averaged; the linear predictor is solved so that averaging over all random effects gives it. Random effects: participant (SD 1.5, or from the intraclass correlation in the planning scenarios), participant-by-amount, participant-by-source and participant-by-block (independent deviations for each level, SD 0.5 each, 12.1.8), scene (SD 0.4) and scene-by-source (SD 0 or 0.3); block 2 carries the same participant, source and scene effects as block 1. Block 2 is drawn twice from the same random effects and uniform draws, once with the setting's own rule-stated values and once with P(divided | AI, large, rule stated) at the failing value.

## Changes from the between-subjects version

- Source is within participants (12.3); the primer factor is replaced by the fixed block 2; the practice covariate and the main0r and main1r settings are gone (12.1.2).
- Each person sees all ten scenes: eight in block 1, two in block 2 (before: eight of ten, the other two kept for the "would" block). Ten lists replace five.
- Random effects follow 1.8 revised: by-participant and by-scene slopes for the source, item and amount codes (scope) and for the source and amount codes (G).
- G is estimated from block 1 alone; the instrument check from the registration's rule model on the four large-addition trials of both blocks.
- New generating terms: participant-by-source SD 0.25 (creativity) and 0.5 (log-odds), and participant-by-block SD 0.5 (log-odds). sens15 raises every participant-by-cell SD by 15/7.
- New settings: fallback (fall0, fall1) for every family; G at the bound; the instrument check at a failing value; the planning scenarios of G in main1 and fall1.

## Timing

Mean seconds in this run (10 cores in parallel): scope 4.48 per fit (three account fits per dataset, five in the residue datasets); G and instrument check 11.49 per dataset (G fit 11.16, each instrument-check fit 0.16); Laplace check, nAGQ = 1, 221.79 per G fit and 0.67 per instrument-check fit. Estimated full run at the default numbers of datasets (1000, 500, 200) on 11 cores: 1295 minutes (scope 105, G and instrument check 583, Laplace 607), from each setting's mean time. Elapsed this run: 1442.0 minutes.

## Software and checksums

- R version 4.5.2 (2025-10-31); aarch64-apple-darwin20; macOS Tahoe 26.6.2
- Attached packages: lmerTest 3.2-1, lme4 2.0-1, Matrix 1.7-5
- Loaded packages: vctrs 0.7.3, nlme 3.1-169, cli 3.6.6, rlang 1.2.0, reformulas 0.4.4, generics 0.1.4, S7 0.2.2, minqa 1.2.8, glue 1.8.1, scales 1.4.0, grid 4.5.2, tibble 3.3.1, MASS 7.3-65, numDeriv 2016.8-1.1, lifecycle 1.0.5, compiler 4.5.2, dplyr 1.2.1, RColorBrewer 1.1-3, pkgconfig 2.0.3, Rcpp 1.1.1-1.1, farver 2.1.2, lattice 0.22-9, nloptr 2.2.1, R6 2.6.1, tidyselect 1.2.1, pillar 1.11.1, Rdpack 2.6.6, splines 4.5.2, magrittr 2.0.5, rbibutils 2.4.1, tools 4.5.2, gtable 0.3.6, boot 1.3-32, ggplot2 4.0.3
- Run date: 2026-10-29
- SHA-256 of sim_A1.R: f3b0b9e7e1bd618e9a9eea774c7c21b7f4ae16ba10086d842fcdd6474b758b5e (after the run, one report sentence describing the rule model's random effects was corrected to match the code; the run's file, which differed only in that sentence, had 9d89c86930d565c7b36943a09312b65504b9de698d235c0056a3371885799469)
- SHA-256 of sim_common.R: 26158be94c207ae9ab1c12103fe0fcd7a7720cbe56ee2f34e5b5a30b2800d275

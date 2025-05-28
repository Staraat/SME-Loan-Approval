# SME-Loan-Approval

End-to-end data-science pipeline that automates SME-loan approvals for **Lasiandra Finance Inc. (LFI)**.  
Built with **SAS OnDemand for Academics** and documented in a 90-page report.

---

## Project Goals
1. Shorten LFI’s manual loan-review cycle from days to seconds.  
2. Predict loan-approval outcomes (Y/N) with > 80 % precision and recall.  
3. Provide clear, auditable code and reports for risk & compliance teams.

---

## Tools & Libraries
- SAS OnDemand for Academics
- PROC LOGISTIC, PROC SQL, PROC CONTENT(S)  
- Macro programming for repetitive EDA & imputation  
- Report generation with ODS PDF

---

## Workflow Summary

| Step | SAS Procedures / Actions | Highlights |
|------|--------------------------|------------|
| **1 Data Import** | `PROC IMPORT` → permanent lib `LIBOCT34` | 1 666 rows, 13 categorical & 7 numeric vars. |
| **2 Metadata & EDA** | `PROC CONTENTS`, `PROC SQL` | Auto-generated data dictionary (p. 7). |
| **3 Missing-value Handling** | Custom macros (`%IMPUTE_CAT`, `%IMPUTE_NUM`) | Mode/median imputation reduced NA rate from 6 % → 0 %. |
| **4 Feature Engineering** | Dummy encoding, ratio features | Added *Income-to-Loan* and *Family-Load* ratios. |
| **5 Modeling** | `PROC LOGISTIC` + stepwise | Final model: **AUC 0.84, Accuracy 0.81** on hold-out. |
| **6 Scoring & Reporting** | `PROC SCORE`, `ODS PDF` | Generates per-applicant probabilities (see `MY_LAS_REPORT*.pdf`). |

---

## Key Findings
- Credit-history & Loan-duration are the strongest approval drivers.  
- Applicants with loan ratio > 4× monthly income see a 65 % drop in approval odds.  
- Automated model cuts manual review queue by ~70 % while hitting bank-targeted risk thresholds.


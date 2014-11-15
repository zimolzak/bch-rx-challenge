BCH Rx Challenge
====

Purpose: Analysis of e-prescribing data. Workflow so far fixes some
problems with commas in the original CSV, and then proceeds with
analysis.

1. Run `./fix.pl Drug_Details.csv > fixed_drug_details.csv`.

2. Run `comma_distribution.sh` to prove to yourself that
`Medication_History_Records.csv` doesn't need to be fixed. (First
check the source and change the input filename as necessary.)

3. Run `./make_names.sh` to generate a text file of interesting things
found in `fixed_drug_details.csv`. (First check the source and change
the input/output paths as necessary.)

4. Run `analysis.sas`, which will import and do basic analyses on
`fixed_drug_details.csv`, such as univariate density plots. (First
check the source and change the input/output paths as necessary.)
[Note: test.txt is just a few lines of the pipe-delimited file,
roughly aligned with spaces, to make it easy for me to examine quickly
when dealing with import problems.]

5. Or run `import.R`, which will do basically the same import and
analyses. This also does some proof of concept bivariate analyses of a
continuous vs a categorical variable.

6. Run `exploratory.R`, which will import and do some fanicer analyses
like finding the most commonly prescribed drugs, delays between rx
date and fill date, and visualizations of population rx fill dates &
med supplies.

Results
----

* Plain text outputs at
  https://github.com/zimolzak/bch-rx-challenge/tree/master/results

* Image outputs at
  https://www.dropbox.com/sh/1rzxfje5j2kji9b/AAB8uHnR9q9l7zdj1EEyNiMza?dl=0

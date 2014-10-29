BCH Rx Challenge
====

Purpose: Analysis of e-prescribing data. Workflow so far fixes some
problems with commas in the original CSV, and then does some basic
univariate statistics and other tests.

1. Run `fix.pl` on Drug_Details.csv, to create fixed_drug_details.csv.

2. Run `analysis.sas` on fixed_drug_details.csv. Or run `import.R` if
you prefer R over SAS. (First check the source and change the
input/output paths as necessary.) **Image outputs are all here:**
https://www.dropbox.com/sh/1rzxfje5j2kji9b/AAB8uHnR9q9l7zdj1EEyNiMza?dl=0

3. (Optional) Run `make_names.sh` to find interesting things. (First
check the source and change the input/output paths as necessary.)

4. (Optional) Run `comma_distribution.sh` to prove to yourself that
Medication_History_Records.csv doesn't need to be fixed. (First check
the source and change the input filename as necessary.)

Note: test.txt is just a few lines of the pipe-delimited file, roughly
aligned with spaces, to make it easy to examine quickly.


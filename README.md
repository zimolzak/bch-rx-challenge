BCH Rx Challenge
====

Purpose: Analysis of e-prescribing data. Workflow so far fixes some
problems with commas in the original CSV, and then does some basic
univariate statistics and other tests.

1. Run fix.pl on Drug_Details.csv, to create fixed_drug_details.csv.

2. Run analysis.sas on fixed_drug_details.csv. (First check the source
and change the input/output paths as you like.)

3. Run make_names.sh. (First check the source and change the
input/output paths as you like.)

4. Run comma_distribution.sh. (First check the source and change the
input filename as you like.)

Note: test.txt is just a few lines of the pipe-delimited file, roughly
aligned with spaces, to make it easy to examine quickly.

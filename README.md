BCH Rx Challenge
====

Purpose: Analysis of e-prescribing data.

Primary judging criteria
----

1. Synthesis. Link patients to drugs. Are you flexible in accepting
data that looks different (or bigger quantities)? Are you scaleable?

2. Analysis. Deduplicate, find gaps based on fill numbers, quantify
gaps, analyze based on patients, based on set of providers, and so on.
Goal is to deliver in ambulatory at POC. Put yourself in position of
provider who's about to write a Rx. Help the Dr get to what matters in
the med hx file. Judged based on: if you're rule-based, what are your
rules like? Is your analysis broad? This judging is somewhat
quantitative. Regional analysis? Extra credit for any form of
predictive power.

3. Visualization. What audience can it hit? More qualitative criteria.
Note that other audiences might include public health, ACOs, or
anybody you can think of. Sounds like that's basically extra credit
for such flexibility. Preference would be to have very polished
product for 1 type of user, rather than a rough one for 3 users.

Our description of approach from proposal
-------
1. noninterruptive indicator of adherence on home screen

2. click thru for screen of multiple meds with more details

3. click thru for screen of a single med with highest detail

Results
----

* Plain text outputs at
  https://github.com/zimolzak/bch-rx-challenge/tree/master/results

* Image outputs at
  https://www.dropbox.com/sh/1rzxfje5j2kji9b/AAB8uHnR9q9l7zdj1EEyNiMza?dl=0

![rx fill visualization](https://dl.dropboxusercontent.com/u/38640281/github_img/Screen%20Shot%202014-11-15%20at%209.16.46%20AM.png)

Instructions
----

1. Run `./fix.pl Drug_Details.csv > fixed_drug_details.csv`, to fix
some problems with commas in the original CSV.

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

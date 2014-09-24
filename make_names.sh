#!/bin/sh

# Create a file containing an interesting list of first names found in
# the Sig. fields of the prescriptions.

# usage: ./make_names.sh

perl -ne 'print if s/.*(\|G [A-Z]*).*/$1/' fixed_drug_details.csv |sort |uniq -c |sort -nr > results/names.txt

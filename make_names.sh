#!/bin/sh

perl -ne 'print if s/.*(\|G [A-Z]*).*/$1/' fixed_drug_details.csv |sort |uniq -c |sort -nr > results/names.txt

#!/bin/sh
# Proves that Medication_History_Records.csv has same num of commas on all its lines.

# usage: ./comma_distribution.sh

perl -ne '$y = ($_ =~ tr/,/,/); print "$y\n"' Medication_History_Records.csv |sort | uniq -c


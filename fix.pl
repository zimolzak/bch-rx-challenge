#!/usr/bin/perl -w

# Ad hoc code to tranform the ambiguous Drug_Details.csv into a
# pipe-delimited file. The ambiguous CSV starts with two good fields
# (messageid, rowid), followed by three problematic fields
# (DrugDescription, DaySupply, Directions), then the rest of the
# fields are good (except for DrugCodedStrength).

# usage: ./fix.pl Drug_Details.csv > fixed_drug_details.csv

use strict;

while(<>){
    if (/^messageid/) { # first line is guaranteed correct
	s/,/|/g;
	print;
	next;
    }
    chomp;
    my $firstpart = $_;
    $firstpart =~ s/^([1234567890abcdef]+,\d*,).*/$1/;  # messageid, rowid
    my $lastpart = $_;
    $lastpart =~ s{.*(,[N/A0123456789]+,ND,.*)}{$1}; # DrugCodedProductCode, ...

    my $length_middle = length($_) - length($lastpart) - length($firstpart);
    my $middlepart = substr($_, length($firstpart), $length_middle);
    $firstpart =~ s/,/|/g;
    $middlepart =~ s/(.*),(\d*),(.*)/$1|$2|$3/; # DaySupply is always numeric

    # clean up DrugCodedStrength 
    $lastpart =~ s/(\d),(\d\d\d mg)/$1$2/;
    $lastpart =~ s/(\d),(\d\d\d unit)/$1$2/g;
    $lastpart =~ s/(\d),(\d\d\d mcg)/$1$2/;
    $lastpart =~ s/(1:[\d]),(000)/$1$2/;

    $lastpart =~ s/,/|/g;

    print $firstpart . $middlepart . $lastpart . "\n";
    
}

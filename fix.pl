#!/usr/bin/perl -w
# usage: ./fix.pl Drug_Details.csv > fixed_drug_details.csv
use strict;

while(<>){
    if (/^messageid/) {
	s/,/|/g;
	print;
	next;
    }
    chomp;
    my $firstpart = $_;
    $firstpart =~ s/^([1234567890abcdef]+,\d*,).*/$1/;
    my $lastpart = $_;
    $lastpart =~ s{.*(,[N/A0123456789]+,ND,.*)}{$1};

#     my @dm1 = split(/,/, $firstpart);
#     my @dm2 = split(/,/, $lastpart);
#     my $m = $#dm1;
#     $m++;
#     print "$m \n"; # proves that $firstpart always has 2 commas on this data
#     my $n = $#dm2;
#     $n++;
#     print $lastpart . "\n"  if $n > 14;

    my $length_middle = length($_) - length($lastpart) - length($firstpart);
    my $middlepart = substr($_, length($firstpart), $length_middle);
    $firstpart =~ s/,/|/g;
    $middlepart =~ s/(.*),(\d*),(.*)/$1|$2|$3/;

    $lastpart =~ s/(\d),(\d\d\d mg)/$1$2/;
    $lastpart =~ s/(\d),(\d\d\d unit)/$1$2/g;
    $lastpart =~ s/(\d),(\d\d\d mcg)/$1$2/;
    $lastpart =~ s/(1:[\d]),(000)/$1$2/;

    $lastpart =~ s/,/|/g;

    print $firstpart . $middlepart . $lastpart . "\n";
    
}

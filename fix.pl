#!/usr/bin/perl -w
use strict;

while(<>){
    chomp;
    my $firstpart = $_;
    $firstpart =~ s/^([1234567890abcdef]+,\d*,).*/$1/;
    my $lastpart = $_;
    $lastpart =~ s/.*(,[N\/A0123456789]+,ND,.*)/$1/;

    my @dm1 = split(/,/, $firstpart);
    my @dm2 = split(/,/, $lastpart);
    my $m = $#dm1;
    $m++;
    # print "$m \n";
    my $n = $#dm2;
    $n++;
    print $lastpart . "\n"  if $n > 14;
}

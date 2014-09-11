#!/usr/bin/perl -w
use strict;

while(<>){
    chomp;
    my $firstpart = $_;
    $firstpart =~ s/^([1234567890abcdef]+,\d*,).*/$1/;
    my $lastpart = $_;
    $lastpart =~ s/.*(,[N\/A0123456789]+,ND,.*)/$1/;
    print $lastpart . "\n";
}

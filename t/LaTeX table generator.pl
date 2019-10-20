#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';


my $input_file;
open ($input_file, 't/in.txt') or die("$! can\'t be opened");

my $summary_row = 0;
my $summary_col = 0;
my $header_row = 0;
my $header_col = 0;
my $transposition = 0;

my @separators_row = ();
my @separators_col = ();
set_script_options(@ARGV);
valid_separators();

sub valid_separators{
    if(scalar @separators_row eq 0){
        print('arguments must contain separators for rows');
        exit(0);
    }
    if(scalar @separators_row eq 0){
        print('arguments must contain separators for rows');
        exit(0);
    }
    foreach my $r (@separators_row){
        foreach my $c (@separators_col){
            if($r eq $c){
                print("separators for rows and columns must be unique.
                 Separator $r occurs in rows and columns separators");
                exit(0);
            }
        }
    }
}
sub set_script_options{

    foreach my $word (@_){
        if ($word eq '-sr'){
            $summary_row = 1;
        } elsif($word eq '-sc'){
            $summary_col = 1;
        }elsif($word eq '-hr'){
            $header_row = 1;
        }elsif($word eq '-hc'){
            $header_col = 1;
        }elsif($word eq '-tr') {
            $transposition = 1;
        } elsif($word =~ m/^-c_/){#column separators
            my $temp = substr($word, 3);
            if(length($temp) == 0){
                print("argument must contain separator after $word");
                exit(0);
            }
            push(@separators_col, $temp);
        } elsif($word =~ m/^-r_/){#rows separators
            my $temp = substr($word, 3);
            if(length($temp) == 0){
                print("argument must contain separator after $word");
                exit(0);
            }
            push(@separators_row, $temp);
        } else {
            print ("$word is not acceptable as script argument\n");
            exit(0);
        }
    }
}
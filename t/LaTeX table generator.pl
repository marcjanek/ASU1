#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

my $summary_row = 0;
my $summary_col = 0;
my $header_row = 0;
my $header_col = 0;
my $transposition = 0;

my @separators_row = ();
my @separators_col = ();
set_script_options(@ARGV);
valid_separators();
my @dataTable=load_data_from_file();
valid_rows_size();




my $val = 0;
sub valid_rows_size{
    if(scalar(@dataTable) eq 0){
        print("empty table\n");
    } elsif(scalar(@dataTable) eq 1){
        print("one row table\n");
    } else {
        for my $i (1..(scalar(@dataTable)-1)){
            if(scalar(@{$dataTable[0]}) ne scalar(@{$dataTable[$i]})){
                print("size of each row must be equal, when row with index 0 and size = ".scalar(@{$dataTable[0]})
                    ." not equals row with index $i and size = ".scalar(@{$dataTable[$i]})."\n");
                exit(0);
            }
        }
    }
}
sub load_data_from_file{
    my $input_file;
    open ($input_file, 't/in.txt') or die("$! can\'t be opened\n");
    my $data = join('', <$input_file>);
    $data =~ s/\s//g;

    my @separated_data_rows = split(/[join('',@separators_row)]/, $data);
    my $separators_col_s = join('',@separators_col);
    my @table;
    for my $i (0..(scalar(@separated_data_rows)-1)){
        my @cells = split(/[$separators_col_s]/, $separated_data_rows[$i]);
        for my $j (0..(scalar(@cells)-1)){
            $table[$i][$j]= $cells[$j];
        }
    }
    close($input_file);
    return @table;
}
sub valid_separators{
    if(scalar @separators_row eq 0){
        print("arguments must contain separators for rows\n");
        exit(0);
    }
    if(scalar @separators_row eq 0){
        print("arguments must contain separators for rows\n");
        exit(0);
    }
    foreach my $r (@separators_row){
        foreach my $c (@separators_col){
            if($r eq $c){
                print("separators for rows and columns must be unique.
                 Separator $r occurs in rows and columns separators\n");
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
                print("argument must contain separator after $word\n");
                exit(0);
            }
            push(@separators_col, $temp);
        } elsif($word =~ m/^-r_/){#rows separators
            my $temp = substr($word, 3);
            if(length($temp) == 0){
                print("argument must contain separator after $word\n");
                exit(0);
            }
            push(@separators_row, $temp);
        } else {
            print ("$word is not acceptable as script argument\n");
            exit(0);
        }
    }
}
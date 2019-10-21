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
@dataTable = transpose() if($transposition eq 1);
save_data(create_output_rows());
#subs

sub save_data{
    my $output_file;
    open($output_file, '>', 'src/out.txt');
    print $output_file join("\n",@_);
    close ($output_file);
}
sub create_output_rows{
    my @rows;
    #set data rows and add header row
    for (my $idx = 0; $idx < @dataTable; $idx++) {
        $rows[$idx+2]=($header_row eq 1 ? '& ' : '').join(' & ',@{$dataTable[$idx]}).' \\\\ \hline';
    }
    #set header column
    if($header_col eq 1) {
        $rows[1] = ($header_row eq 1 ? '& ' : '') . "& " x (@{$dataTable[0]} - 1) . '\\\\ \hline';
    }
    #set begins
    $rows[0] = '\documentclass{article}\begin{document}\begin{tabular}{';
    $rows[0] .= ' |' if($header_row eq 1 or ((@{$dataTable[0]}-1+ ($header_row eq 1 ? 1:0)) ne 0));
    $rows[0] .= ' c |'x(@{$dataTable[0]}-1+ ($header_row eq 1 ? 1:0));
    $rows[0] .='|' if(($summary_col eq 1 ) or ((@{$dataTable[0]} -1+($header_row eq 1 ? 1:0) ) eq 0));
    $rows[0] .= ' c |}';
    $rows[0] .= ' \hline' if($header_col eq 1);
    #set summary row
    if($summary_row eq 1){
        $rows[@dataTable] .= ' \hline';
    }
    #set ends
    $rows[@dataTable+2] = '\end{tabular}\end{document}';
    $rows[1] = '\hline' if(!defined $rows[1]);
    return @rows;
}
sub transpose{
    return @dataTable if(@dataTable eq 1);
    my @matrix;
    for my $row (0..@dataTable-1) {
        for my $col (0..@{$dataTable[$row]}-1) {
            $matrix[$col][$row] = $dataTable[$row][$col];
        }
    }
    @matrix;
}
sub valid_rows_size{
    if(@dataTable eq 0){
        print("table is empty, can't create LaTeX table\n");
        exit(0);
    } else {
        for my $i (1..(@dataTable-1)){
            if(@{$dataTable[0]} ne @{$dataTable[$i]}){
                print("size of each row must be equal, when row with index 0 and size = "
                    .scalar(@{$dataTable[0]})
                    ." not equals row with index $i and size = "
                    .scalar(@{$dataTable[$i]})
                    ."\n");
                exit(0);
            }
        }
    }
}
sub load_data_from_file{
    my $input_file;
    open ($input_file, 'src/in.txt') or die("$! can\'t be opened\n");
    my $data = join('', <$input_file>);
    $data =~ s/\s//g;

    my @separated_data_rows = split(/[join('',@separators_row)]/, $data);
    my $separators_col_s = join('',@separators_col);
    my @table;
    for my $i (0..(@separated_data_rows-1)){
        my @cells = split(/[$separators_col_s]/, $separated_data_rows[$i]);
        for my $j (0..(@cells-1)){
            $table[$i][$j]= $cells[$j];
        }
    }
    close($input_file);
    return @table;
}
sub valid_separators{
    if( @separators_row eq 0){
        print("arguments must contain separators for rows\n");
        exit(0);
    }
    if(@separators_row eq 0){
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
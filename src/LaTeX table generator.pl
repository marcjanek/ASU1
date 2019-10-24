#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

my $summary_row = 0;
my $summary_col = 0;
my $header_row = 0;
my $header_col = 0;
my $transposition = 0;

my $input;
my $output;

my @separators_row = ();
my @separators_col = ();

set_script_options(@ARGV);
valid_input_and_output();
valid_separators();
my @dataTable=load_data_from_file();
valid_rows_size();
@dataTable = transpose() if($transposition eq 1);
save_data(create_output_rows());

#subs

sub save_data{
    my $output_file;
    open $output_file, '>', $output;
    print $output_file join "\n", @_;
    close $output_file;
}

sub create_output_rows {
    my @rows;
    #set data rows and add header row
    for (my $idx = 0; $idx < @dataTable; $idx++) {
        $rows[$idx+2] = ($header_row eq 1 ? '& ' : '').join(' & ',@{$dataTable[$idx]});
        $rows[$idx+2] .= ' & '.sum_column_values($idx) if($summary_col eq 1);
        $rows[$idx+2] .= ' \\\\ \hline';
    }
    #set header column
    if ($header_col eq 1) {
        $rows[1] = ($header_row eq 1 ? '& ' : '') . "& " x (@{$dataTable[0]} - 1 + ($summary_col eq 1 ? 1:0)) . '\\\\ \hline';
    }
    #set begins
    $rows[0] = '\documentclass{article}\begin{document}\begin{tabular}{';
    if ($header_row eq 1){
        $rows[0] .= ' | c |';
    } else {
        $rows[0] .= ' | ';
    }
    $rows[0] .= ' c |' x (@{$dataTable[0]});


    $rows[0] .='| c |' if ($summary_col eq 1);
    $rows[0] .='}';
    $rows[0] .= ' \hline' if ($header_col eq 1);
    #set summary row
    $rows[@dataTable+2] = '';
    if ($summary_row eq 1) {
        $rows[@dataTable + 2] .= '\hline ';
        $rows[@dataTable + 2] .= '& ' if($header_row eq 1);
        $rows[@dataTable + 2] .=(join ' & ', sum_row_values())
            .' \\\\ \hline';
    }
    #set ends
    $rows[@dataTable+3] = '\end{tabular}\end{document}';
    $rows[1] = '\hline' if(!defined $rows[1]);
    return @rows;
}
sub sum_row_values {
    my @array = ();
    for my $row (0..@{$dataTable[0]}-1) {
        my $sum = 0;
        for my $col (0..@dataTable-1) {
            $sum += $dataTable[$col][$row];
        }
        push @array, $sum;
    }
    if ($summary_col eq 1) {
        my $sum = 0;
        foreach (@array) {
            $sum += $_;
        }
        push @array, $sum;
    }
    @array;
}
sub sum_column_values {
    my $sum = 0;
    for my $col (0..@{$dataTable[$_[0]]}-1) {
        $sum += $dataTable[$_[0]][$col];
    }
    $sum;
}

sub transpose{
    return @dataTable if (@dataTable eq 1);
    my @matrix;
    for my $row (0..@dataTable-1) {
        for my $col (0..@{$dataTable[$row]}-1) {
            $matrix[$col][$row] = $dataTable[$row][$col];
        }
    }
    @matrix;
}

sub valid_rows_size {
    if (@dataTable eq 0){
        print "table is empty, can't create LaTeX table\n";
        exit(0);
    } else {
        for my $i (1..(@dataTable-1)) {
            if (@{$dataTable[0]} ne @{$dataTable[$i]}){
                print "size of each row must be equal, when row with index 0 and size = "
                    .scalar(@{$dataTable[0]})
                    ." not equals row with index $i and size = "
                    .scalar(@{$dataTable[$i]})
                    ."\n";
                exit 0;
            }
        }
    }
}

sub load_data_from_file {
    my $input_file;
    open ($input_file, $input) or die("$! can\'t be opened\n");
    my $data = join '', <$input_file>;
    $data =~ s/\s//g;

    my @separated_data_rows = split /[join('',@separators_row)]/, $data;
    my $separators_col_s = join '',@separators_col;
    my @table;
    for my $i (0..(@separated_data_rows-1)) {
        my @cells = split /[$separators_col_s]/, $separated_data_rows[$i];
        for my $j (0..(@cells-1)) {
            $table[$i][$j]= $cells[$j];
        }
    }
    close $input_file;
    return @table;
}

sub valid_separators {
    if (@separators_row eq 0) {
        print "arguments must contain separators for rows\n";
        exit 0;
    }
    if (@separators_row eq 0) {
        print "arguments must contain separators for rows\n";
        exit 0;
    }
    foreach my $r (@separators_row) {
        foreach my $c (@separators_col) {
            if ($r eq $c) {
                print "separators for rows and columns must be unique.
                 Separator $r occurs in rows and columns separators\n";
                exit 0;
            }
        }
    }
    if ((join('', @separators_row).join('', @separators_col)) =~ /\d/) {
        print "separator can't be number";
        exit 0;
    }
}
sub valid_input_and_output {
    if (!defined($input)) {
        print "arguments must contain input path\n";
        exit 0;
    } elsif (!defined($output)) {
        print "arguments must contain output path\n";
        exit 0;
    }
}

sub set_script_options {
    foreach my $word (@_){
        if ($word eq '-sr') {
            $summary_row = 1;
        } elsif ($word eq '-sc') {
            $summary_col = 1;
        } elsif ($word eq '-hr') {
            $header_row = 1;
        } elsif ($word eq '-hc') {
            $header_col = 1;
        } elsif ($word eq '-tr') {
            $transposition = 1;
        } elsif ($word =~ m/^-c=/) {#column separators
            my $temp = substr $word, 3;
            if(length(substr($word, 3)) == 0){
                print "argument must contain separator after $word\n";
                exit 0;
            } elsif (length($temp) > 1) {
                print "separator must contain only one char\n";
                exit 0;
            }
            push @separators_col, $temp;
        } elsif ($word =~ m/^-r=/) {#rows separators
            my $temp = substr $word, 3;
            if (length($temp) == 0) {
                print "argument must contain separator after $word\n";
                exit 0;
            } elsif (length($temp) > 1) {
                print "separator must contain only one char\n";
                exit 0;
            }
            push @separators_row, $temp;
        } elsif ($word =~ m/^-in=/) {
            my $temp = substr $word, 4;
            if(length($temp) == 0){
                print "argument must contain input path after $word\n";
                exit 0;
            } elsif (defined($input)) {
                print "arguments must contain only one input path\n";
                exit 0;
            }
            $input = $temp;
        } elsif ($word =~ m/^-out=/) {
            my $temp = substr $word, 5;
            if(length($temp) == 0){
                print "argument must contain output path after $word\n";
                exit 0;
            } elsif (defined($output)) {
                print "arguments must contain only one output path\n";
                exit 0;
            }
            $output = $temp;
        }
        else {
            print "$word is not acceptable as script argument\n";
            exit 0;
        }
    }
}
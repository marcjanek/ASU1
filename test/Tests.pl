#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use Test::Simple;
use Test::More tests => 8;
use IPC::System::Simple qw(system capture);

#tests
test((' -tr -hc -hr -sr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c||c|}\\hline&\\\\\\hline\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -hr -sr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c||c|}\\hline&\\\\\\hline\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hr -sr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c||c|}\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hr -sr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c||c|}\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));

test((' -tr -hc -sr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{||c|}\\hline\\\\\\hline\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -sr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{||c|}\\hline\\\\\\hline\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
#todo
test((' -tr -sr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c||c|}\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -sr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c||c|}\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));




done_testing();
#end of tests

sub test{
    my $out =remove_whitespace(perform_script(@_));
    ok ($_[2] eq $out,"table = $_[1] with arguments = $_[0]");
}

sub remove_whitespace{
    $_[0] =~ s/\s//g;
    $_[0];
}
sub perform_script{
    input_file($_[1]);
    system($^X, 'src/LaTeX table generator.pl', set_array($_[0]));
    load_output();
}
sub input_file{
    my $input;
    open($input, '>', 'src/in.txt');
    print $input join("\n",@_);
    close ($input);
}
sub set_array{
    my @array = ();
    foreach my $i (split(" ",$_[0])){
        push @array,$i
    }
    @array;
}
sub load_output{
    my $input_file;
    open ($input_file, 'src/out.txt') or ok(0 eq 1,'fail');
    my $data = join('', <$input_file>);
    close($input_file);
    $data;
}
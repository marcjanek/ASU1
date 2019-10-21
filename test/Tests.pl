#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use Test::Simple;
use Test::More tests => 73;
use IPC::System::Simple qw(system capture);

#tests for types of LaTeX table
test((' -tr -hc -hr -sr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c||c|}\\hline&\\\\\\hline\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -hr -sr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c||c|}\\hline&\\\\\\hline\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hr -sr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c||c|}\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hr -sr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c||c|}\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -sr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|}\\hline\\\\\\hline\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -sr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|}\\hline\\\\\\hline\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -sr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|}\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -sr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|}\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -hr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c||c|}\\hline&\\\\\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -hr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c||c|}\\hline&\\\\\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c||c|}\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c||c|}\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|}\\hline\\\\\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|}\\hline\\\\\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|}\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -sc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|}\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -hr -sr -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|}\\hline&\\\\\\hline\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -hr -sr -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|}\\hline&\\\\\\hline\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hr -sr -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|}\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hr -sr -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|}\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -sr -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|}\\hline\\\\\\hline\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -sr -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|}\\hline\\\\\\hline\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -sr -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|}\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -sr -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|}\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -hr -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|}\\hline&\\\\\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -hr -c_- -c_. -r_; -r_\'', '1;',     "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|}\\hline&\\\\\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hr -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|}\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hr -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|}\\hline&1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|}\\hline\\\\\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|}\\hline\\\\\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|}\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -c_- -c_. -r_; -r_\'', '1;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|}\\hline1\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -hr -sr -sc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c||c|}\\hline&&&\\\\\\hline&0&10&20\\\\\\hline&1&11&21\\\\\\hline&2&12&22\\\\\\hline&3&13&23\\\\\\hline\\hline&4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -hr -sr -sc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c|c||c|}\\hline&&&&&\\\\\\hline&0&1&2&3&4\\\\\\hline&10&11&12&13&14\\\\\\hline\\hline&20&21&22&23&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hr -sr -sc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c||c|}\\hline&0&10&20\\\\\\hline&1&11&21\\\\\\hline&2&12&22\\\\\\hline&3&13&23\\\\\\hline\\hline&4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hr -sr -sc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c|c||c|}\\hline&0&1&2&3&4\\\\\\hline&10&11&12&13&14\\\\\\hline\\hline&20&21&22&23&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -sr -sc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c||c|}\\hline&&\\\\\\hline0&10&20\\\\\\hline1&11&21\\\\\\hline2&12&22\\\\\\hline3&13&23\\\\\\hline\\hline4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -sr -sc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c||c|}\\hline&&&&\\\\\\hline0&1&2&3&4\\\\\\hline10&11&12&13&14\\\\\\hline\\hline20&21&22&23&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -sr -sc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c||c|}\\hline0&10&20\\\\\\hline1&11&21\\\\\\hline2&12&22\\\\\\hline3&13&23\\\\\\hline\\hline4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -sr -sc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c||c|}\\hline0&1&2&3&4\\\\\\hline10&11&12&13&14\\\\\\hline\\hline20&21&22&23&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -hr -sc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c||c|}\\hline&&&\\\\\\hline&0&10&20\\\\\\hline&1&11&21\\\\\\hline&2&12&22\\\\\\hline&3&13&23\\\\\\hline&4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -hr -sc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c|c||c|}\\hline&&&&&\\\\\\hline&0&1&2&3&4\\\\\\hline&10&11&12&13&14\\\\\\hline&20&21&22&23&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hr -sc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c||c|}\\hline&0&10&20\\\\\\hline&1&11&21\\\\\\hline&2&12&22\\\\\\hline&3&13&23\\\\\\hline&4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hr -sc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c|c||c|}\\hline&0&1&2&3&4\\\\\\hline&10&11&12&13&14\\\\\\hline&20&21&22&23&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -sc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c||c|}\\hline&&\\\\\\hline0&10&20\\\\\\hline1&11&21\\\\\\hline2&12&22\\\\\\hline3&13&23\\\\\\hline4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -sc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c||c|}\\hline&&&&\\\\\\hline0&1&2&3&4\\\\\\hline10&11&12&13&14\\\\\\hline20&21&22&23&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -sc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c||c|}\\hline0&10&20\\\\\\hline1&11&21\\\\\\hline2&12&22\\\\\\hline3&13&23\\\\\\hline4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -sc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c||c|}\\hline0&1&2&3&4\\\\\\hline10&11&12&13&14\\\\\\hline20&21&22&23&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -hr -sr -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c|}\\hline&&&\\\\\\hline&0&10&20\\\\\\hline&1&11&21\\\\\\hline&2&12&22\\\\\\hline&3&13&23\\\\\\hline\\hline&4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -hr -sr -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c|c|c|}\\hline&&&&&\\\\\\hline&0&1&2&3&4\\\\\\hline&10&11&12&13&14\\\\\\hline\\hline&20&21&22&23&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hr -sr -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c|}\\hline&0&10&20\\\\\\hline&1&11&21\\\\\\hline&2&12&22\\\\\\hline&3&13&23\\\\\\hline\\hline&4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hr -sr -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c|c|c|}\\hline&0&1&2&3&4\\\\\\hline&10&11&12&13&14\\\\\\hline\\hline&20&21&22&23&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -sr -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|}\\hline&&\\\\\\hline0&10&20\\\\\\hline1&11&21\\\\\\hline2&12&22\\\\\\hline3&13&23\\\\\\hline\\hline4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -sr -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c|c|}\\hline&&&&\\\\\\hline0&1&2&3&4\\\\\\hline10&11&12&13&14\\\\\\hline\\hline20&21&22&23&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -sr -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|}\\hline0&10&20\\\\\\hline1&11&21\\\\\\hline2&12&22\\\\\\hline3&13&23\\\\\\hline\\hline4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -sr -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c|c|}\\hline0&1&2&3&4\\\\\\hline10&11&12&13&14\\\\\\hline\\hline20&21&22&23&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -hr -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c|}\\hline&&&\\\\\\hline&0&10&20\\\\\\hline&1&11&21\\\\\\hline&2&12&22\\\\\\hline&3&13&23\\\\\\hline&4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -hr -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;',     "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c|c|c|}\\hline&&&&&\\\\\\hline&0&1&2&3&4\\\\\\hline&10&11&12&13&14\\\\\\hline&20&21&22&23&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hr -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c|}\\hline&0&10&20\\\\\\hline&1&11&21\\\\\\hline&2&12&22\\\\\\hline&3&13&23\\\\\\hline&4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hr -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c|c|c|}\\hline&0&1&2&3&4\\\\\\hline&10&11&12&13&14\\\\\\hline&20&21&22&23&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|}\\hline&&\\\\\\hline0&10&20\\\\\\hline1&11&21\\\\\\hline2&12&22\\\\\\hline3&13&23\\\\\\hline4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -hc -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c|c|}\\hline&&&&\\\\\\hline0&1&2&3&4\\\\\\hline10&11&12&13&14\\\\\\hline20&21&22&23&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|}\\hline0&10&20\\\\\\hline1&11&21\\\\\\hline2&12&22\\\\\\hline3&13&23\\\\\\hline4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -c_- -c_. -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c|c|c|}\\hline0&1&2&3&4\\\\\\hline10&11&12&13&14\\\\\\hline20&21&22&23&24\\\\\\hline\\end{tabular}\\end{document}"));

#tests for separators
test((' -tr -hc -hr -sr -sc -c_- -c_. -r_; -r_\'', '0.1-2.3-4\'10.11-12.13-14;20-21.22.23-24\'', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c||c|}\\hline&&&\\\\\\hline&0&10&20\\\\\\hline&1&11&21\\\\\\hline&2&12&22\\\\\\hline&3&13&23\\\\\\hline\\hline&4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -hr -sr -sc -c_- -c_. -r_;', '0-1.2-3.4;10.11-12.13-14;20.21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c||c|}\\hline&&&\\\\\\hline&0&10&20\\\\\\hline&1&11&21\\\\\\hline&2&12&22\\\\\\hline&3&13&23\\\\\\hline\\hline&4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -hr -sr -sc -c_- -c_. -r_\'', '0-1.2-3.4\'10-11.12-13.14\'20-21.22-23-24\'', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c||c|}\\hline&&&\\\\\\hline&0&10&20\\\\\\hline&1&11&21\\\\\\hline&2&12&22\\\\\\hline&3&13&23\\\\\\hline\\hline&4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -hr -sr -sc -c_- -r_; -r_\'', '0-1-2-3-4;10-11-12-13-14\'20-21-22-23-24\'', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c||c|}\\hline&&&\\\\\\hline&0&10&20\\\\\\hline&1&11&21\\\\\\hline&2&12&22\\\\\\hline&3&13&23\\\\\\hline\\hline&4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -hr -sr -sc -c_- -r_;', '0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c||c|}\\hline&&&\\\\\\hline&0&10&20\\\\\\hline&1&11&21\\\\\\hline&2&12&22\\\\\\hline&3&13&23\\\\\\hline\\hline&4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -hr -sr -sc -c_- -r_\'', '0-1-2-3-4\'10-11-12-13-14\'20-21-22-23-24\'', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c||c|}\\hline&&&\\\\\\hline&0&10&20\\\\\\hline&1&11&21\\\\\\hline&2&12&22\\\\\\hline&3&13&23\\\\\\hline\\hline&4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -hr -sr -sc -c_. -r_; -r_\'', '0.1.2.3.4\'10.11.12.13.14\'20.21.22.23.24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c||c|}\\hline&&&\\\\\\hline&0&10&20\\\\\\hline&1&11&21\\\\\\hline&2&12&22\\\\\\hline&3&13&23\\\\\\hline\\hline&4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -hr -sr -sc -c_. -r_;', '0.1.2.3.4;10.11.12.13.14;20.21.22.23.24;', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c||c|}\\hline&&&\\\\\\hline&0&10&20\\\\\\hline&1&11&21\\\\\\hline&2&12&22\\\\\\hline&3&13&23\\\\\\hline\\hline&4&14&24\\\\\\hline\\end{tabular}\\end{document}"));
test((' -tr -hc -hr -sr -sc -c_. -r_\'', '0.1.2.3.4\'10.11.12.13.14\'20.21.22.23.24\'', "\\documentclass{article}\\begin{document}\\begin{tabular}{|c|c|c||c|}\\hline&&&\\\\\\hline&0&10&20\\\\\\hline&1&11&21\\\\\\hline&2&12&22\\\\\\hline&3&13&23\\\\\\hline\\hline&4&14&24\\\\\\hline\\end{tabular}\\end{document}"));

done_testing();
#end of tests

sub test {
    ok $_[2] eq remove_whitespace(perform_script(@_)),"table = $_[1] with arguments = $_[0]";
}

sub remove_whitespace {
    $_[0] =~ s/\s//g;
    $_[0];
}

sub perform_script {
    input_file($_[1]);
    system $^X, 'src/LaTeX table generator.pl', set_array($_[0]);
    load_output();
}

sub input_file {
    my $input;
    open $input, '>', 'src/in.txt';
    print $input join "\n",@_;
    close $input;
}

sub set_array {
    my @array = ();
    foreach my $i (split(" ",$_[0])){
        push @array,$i
    }
    @array;
}

sub load_output {
    my $input_file;
    open ($input_file, 'src/out.txt') or ok(0 eq 1,'fail');
    my $data = join '', <$input_file>;
    close $input_file;
    $data;
}
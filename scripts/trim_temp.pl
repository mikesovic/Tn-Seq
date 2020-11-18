#! usr/bin/perl
use warnings;
use strict;

opendir FILES, "temp/FilteredData";
my @files = grep { $_ ne '.' && $_ ne '..' && $_ ne '.DS_Store' } readdir(FILES);
close FILES;

foreach my $file (@files) {
	my $counter = 1;
	open IN, "zcat temp/FilteredData/$file |" or die$!;
	$file =~ s/.gz//;
	open OUT, ">temp/TrimmedData/$file" or die$!;
	
	my $seqlength;
	my $qualstring;
	
	while(<IN>) {
		
		chomp($_);
		
		if ($counter == 1) {
			print OUT "$_\n";
			$counter++;
			next;
		}
		
		elsif ($counter == 2) {
			$counter++;
			$_ =~ s/^pattern_to_trim//;
			$seqlength = length($_);
			print OUT "$_\n";
			next;
		}
		
		elsif ($counter == 3) {
			print OUT "$_\n";
			$counter++;
			next;
		}
		
		elsif ($counter == 4) {
			$qualstring = substr($_, $seqlength*(-1));
			print OUT "$qualstring\n";
			$counter = 1;
		}
	}
}	


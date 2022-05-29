#!/usr/bin/perl

$outdir = "/home/groups/oroaklab/demultiplex/index_and_annotation_files";
$indexList = "/home/groups/oroaklab/demultiplex/index_and_annotation_files/adey_10bp_indexes.txt";

$tn5x3_8 = "/home/groups/oroaklab/src/unidex/indexes/s3_Tn5x3_8bp.txt";
$tn5_8 = "/home/groups/oroaklab/src/unidex/indexes/s3_Tn5_8bp.txt";

$die = "

ARGV0 = mode name  (include date or other unique identifier)
ARGV1-N = indexN=123-456,234,779 OR 'tn5_8' or '3xtn5_8'

Outdir = $outdir
IndexList = $indexList
tn5_8 = $tn5_8
tn5x3_8 = $tn5x3_8

Will generate index files in the output directory and then report
the entry is for the 'indexN=' fields in the mode cfg file.
Tn5 names are for the in-line tn5 indexes and pulls the default
files for those.

";

if (!defined $ARGV[1]) {die $die};

open IN, "$indexList";
while ($l = <IN>) {
	chomp $l;
	($id,$index) = split(/\t/, $l);
	$ID_index{$id} = $index;
} close IN;

$call = "Mode = $ARGV[0]\nIndexes:\n";
for ($i = 1; $i < @ARGV; $i++) {
	($indexN,$info) = split(/=/, $ARGV[$i]);
	if ($info =~ /tn5x3_8/i) {
		$call .= "$indexN=$tn5x3_8\t";
	} elsif ($info =~ /tn5_8/i) {
		$call .= "$indexN=$tn5_8\t";
	} else {
		open OUT, ">$outdir/$ARGV[0]_$indexN.txt";
		@P = split(/,/, $info);
		foreach $nset (@P) {
			if ($nset =~ /-/) {
				($start,$end) = split(/-/, $nset);
				for ($id = $start; $id <= $end; $id++) {
					if (defined $ID_index{$id}) {
						print OUT "$ID_index{$id}";
					} else {
						print STDERR "WARNING: Index $indexN specified as $id cannot be parsed or does not exist!\n";
					}
				}
			} else {
				if (defined $ID_index{$nset}) {
					print OUT "$ID_index{$nset}";
				} else {
					print STDERR "WARNING: Index $indexN specified as $nset cannot be parsed or does not exist!\n";
				}
			}
		}
		close OUT;
		$call .= "$indexN=$outdir/$ARGV[0]_$indexN.txt\t";
	}
}

$call =~ s/\t$//;
print "$call\n";
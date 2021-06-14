#!/usr/bin/perl

@corrected_combined	=	("ACGTACGTACGTACGTACGT", "TCGATCGAACGTACGTACGT");
$wildcard_pattern	=	 "ACGT----ACGT----ACGT";

$WILDCARD_ANNOT{$wildcard_pattern} = "MATCHES!";

@PATTERN = split(//, $wildcard_pattern);

for ($i = 0; $i < @PATTERN; $i++) {
	if ($PATTERN[$i] =~ /-|N/) {
		push @WILDCARD_POSITIONS, $i;
	}
}

foreach $seq (@corrected_combined) {
	print "testing $seq\n";
	$trans = $seq;
	substr($trans,$_,1) =~ tr/[ACGT]/-/ foreach @WILDCARD_POSITIONS;
	print "\ttranslated = $trans\n";
	if (defined $WILDCARD_ANNOT{$trans}) {
		print "\tMatches!\n";
	}
}
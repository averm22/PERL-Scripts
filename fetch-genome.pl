#!/usr/bin/perl -w
use strict;
use lib '/data/biocs/b/bio425/bioperl-live';
use lib '/data/biocs/b/bio425/perl5';
use Bio::DB::GenBank;
use Bio::SeqIO;
die "Usage: $0 <genbank_accession, e.g., J00522>\n" unless @ARGV == 1;
my $acc = shift @ARGV;
my $gb = Bio::DB::GenBank->new();
my $seq = $gb->get_Seq_by_acc($acc);
my $out = Bio::SeqIO->new(-file=>">" . $acc.".gb", -format=>'genbank');
$out->write_seq($seq);
exit;

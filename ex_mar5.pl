#!/usr/bin/perl -w
use strict;
use lib '/data/biocs/b/bio425/bioperl-live';
use lib '/data/biocs/b/bio425/perl5';
use warnings;
use Bio::SeqIO;
use Bio::DB::GenBank;


    die "$0 <GenBank accession number>\n" unless @ARGV==1;

my $GenBankId = $ARGV[0];

my $gb = Bio::DB::GenBank->new();
my $seqoutput = $gb->get_Seq_by_acc($GenBankId);
my $output = Bio::SeqIO->new(-file =>"$GenBankId"."gb",-format=>'GenBank');

$output->write_seq($seqoutput);
 

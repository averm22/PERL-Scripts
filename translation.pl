#!/usr/bin/perl -w
use strict;
use warnings;
use lib '/data/biocs/b/bio425/bioperl-live';
use Bio::SeqIO;
use Bio::Seq;

die "$0 <fasta>\n" unless @ARGV ==1;

my $FASTA = $ARGV[0];

my $input_fasta = Bio::SeqIO->new(-file=> $FASTA,-format=>"fasta");
my $seq_obj;
while($seq_obj = $input_fasta->next_seq()){
    my $DNA_obj=$seq_obj;
    my $id = $seq_obj->display_id();
    my $translated = $seq_obj->translate()->seq();
    if($translated =~ /^[A-Z]+\*?$/){
	print ">$id\n $translated\n";
    }
    else{
	warn $seq_obj->id().": Skipped. Translated sequence contains intenal stop codons\n";
    }

}

exit;

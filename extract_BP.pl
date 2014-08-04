#!/usr/bin/perl -w
use strict;
use warnings;
use lib '/data/biocs/b/bio425/bioperl-live';
use Bio::SeqIO;
use Bio::Seq;
use Data::Dumper;
#------------------------------------------------------
#File        :Extract.pl

#Author      :Akanksha Verma

#Data        :February 24,2014

#Description :Emmulate GLIMMER Extraction using BioSeq

#Input       :A FASTA file with 1 DNA and COORD File fom Long-orf

#Output      :A FASTA file with the extracted DNA Sequence
#--------------------------------------------------------

die "$0 <fasta_file><coord_file>\n" unless @ARGV == 2; #checks if 2 arguments were passed

#*****************Reads file names from command line*******#
my $fasta_file = $ARGV[0];
my $coord_file = $ARGV[1];

#********************Read FASTA File***********************#
my $input_fasta = Bio::SeqIO->new(-file => $fasta_file, -format => "fasta"); #Open and read file using SeqIO

my $count_seq=0;
my $seq_obj;
my $DNA_obj;
my $seq_string;

while($seq_obj = $input_fasta->next_seq()){ #loops through file to check the number of sequences
    $DNA_obj=$seq_obj; 
    $seq_string = $seq_obj->seq(); #stores the sequence
    $count_seq++; #keeps count of the sequences
}

#Check if file has more than one DNA sequence
die "More than one DNA sequence found, Quit. \n" if $count_seq > 1;

#***************Open Coord file***************************#
open COORD, "<". $coord_file;
my $subseq;
my $translated;
my $length;
while(<COORD>){
    my $line_read=$_;
    next unless $line_read =~ /^s*(\d+)\s+(\d+)\s+(\S+)\s+(\S+)\s+\S+\s*/; #Parses out the header
    my($id,$cor1,$cor2) = ($1, $2, $3);

    if($cor1 < $cor2){ #checks if the coord are in the correct format
	$subseq = $DNA_obj->subseq($cor1,$cor2); #parses out the subsequence
	$translated = $DNA_obj->trunc($cor1,$cor2)->revcom()->translate()->seq();#translates the sequence
	$length =$DNA_obj->trunc($cor1,$cor2)->length(); #returns the length of the sub-sequence
    }
    else{
	$subseq = $DNA_obj->subseq($cor2,$cor1);#Parses out the subsequence
	$translated = $DNA_obj->trunc($cor2,$cor1)->revcom()->translate()->seq();#translates the sequence 
	$length =$DNA_obj->trunc($cor2,$cor1)->length(); #returns the length of the sub-sequence
    }

    my $trans = $translated;
       $trans =~ s/[\$#@~!&*()\[\];.,:?^ `\\\/]+//g;

#****************Final Output*****************************#
    print ">$id len= $length\n";
    print "$subseq\n";
    print "Translated:\n $trans\n";
}

close COORD;

exit;

#*********************Sub Routines***********************#
#Deletes stop codons within a sequence, except last


#!/usr/bin/perl -w
use strict;
use warnings;
use lib '/data/biocs/b/bio425/bioperl-live';
use Bio::SeqIO;
use Bio::Seq;
use Data::Dumper;
#------------------------------------------------------
#File        :pick-by-id.pl
#Author      :Akanksha Verma
#Data        :March 1,2014
#Description :Extracts sequence by id emulating "blastdbcmd -db entry"
#Input       : 2 arguments: reference genome and target sequence 
#Output      :The matched target sequence printed on screen
#---------------------------------------------------------


die "$0 <Reference genome> <target sequence id>\n" unless @ARGV == 2 #checks if 2 arguments were passed

#*****************Reads file names from command line*******#
my $ref_file = $ARGV[0];
my $target_file = $ARGV[1];


#****************Reads through Reference Genome file*******# 
my $ref_genome = Bio::SeqIO->new(-file => $ref_file, -format =>"pep"); #Open and reads ref file
my $target_id  = Bio::SeqIO->new)-file => $target_file, -format => "pep");#opens and read target seq file


while(my $ref_obj = $ref_file->next_seq()){ #loops through file to check the number of sequences
    
    my $target_obj = $target_file->next_seq();

print $target_obj->seq();
    

}

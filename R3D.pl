#!/usr/bin/perl

use strict;
use warnings;
require LWP::UserAgent;
use LWP::Simple;

#Opens File to be read
open(DATA,"Sample_R3D.txt") or die "Unable to Open file";

#Creates file for Output 
#open (Output,">Output_test.txt") or die "Unable to create Output File";

my $linenumber=1;
my@fields;

my $lastline;
my $Original_RNA;
my $Compared_Sequence;
my $AlignmentScore;
my $SA_Identities;
my $E_Value;
my $RMSD;
my $SAS;
my %Sequence_Identies;
my $data;
my $count=1;
my $counter=1;
my @tokens;
my$token;
while(<DATA>) {

    @tokens = split(' ', $_);
    foreach my $token (@tokens) {
         $counter++;
        if($counter == 7 ){
            $AlignmentScore = $token;
        }
        if($counter == 13){
            $SA_Identities = $token;
            print "\n";
        }
        if($counter == 14){
            $SA_Identities=$SA_Identities.$token;
        }
        
        if($counter == 17){
            $E_Value = $token;
        }
        
        if($counter == 20){
            $RMSD=$token;
            $RMSD =~ s/,+$//; #REMOVING THE EXTRA COMMA
        }
        
        if($counter == 23){
            $SAS = $token;
        }
        
    
        
    }

    
    $lastline = $_ if eof; #searches for the last line in the file
    
    $count++;
}
print"AlignmentScore\t SA \t\t E_Value \t RMSD \t\t SAS\t\n";
print "$AlignmentScore   \t\t $SA_Identities \t $E_Value \t $RMSD \t$SAS \n";
print "This is the last line: $lastline " ; #Prints the last line in the file set


# Saves a copy of the html file entirely







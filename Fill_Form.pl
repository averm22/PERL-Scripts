 #!/usr/bin/perl -w

use strict;
use WWW::Mechanize;
use Browser::Open qw( open_browser );  #used to store a
use LWP::Simple;  #used to store a downloadable file

my $mech = WWW::Mechanize->new();

open(PBD,"<pdbids.txt") or die "Unable to open file";

my $PDB;
my $url;

#While loop

$PDB = "1Y27";


$url ="http://genome.cs.nthu.edu.tw/R3D-BLAST/";
$mech->get($url);

#Fill search and submit;
my $result;
$result = $mech->submit_form(
form_name =>'exec',  #specifies name of form
fields => {PDB => $PDB}, #fills in the search criteria PDB id in this case
button => 'submit'
);
die unless ($mech->success);
my $temp;
my $linked;
my $original;
my @links = $mech->links();

my $weblink;
my $count=0;
my $mainRNA;
for my $link ( @links ) {

    
    $temp = $link->text;
    $linked = $link->url;
    $original = $link->base;
    
    

  
    $original =~s/results\.html$//; #removing the trailing results.html from base link
    $linked =~ s/.\///; #removes extra characters from the front
    
    if($count == 0 ){
        $mainRNA= $temp;
    }
    
    if($temp =~/^[0-9]\S\S\S$/){
        print "$count: ";
        print "$temp: ";
            $count++;
    }
    elsif($temp =~/^View/ || $temp =~ /^TXT/){
        $weblink = $original.$linked;
        print" : $weblink \n\n";
    }
    
}
my $temp2;
$temp2 = $mainRNA.'_'.$count;
my $filename;
$filename = $temp2.'.txt';
my $urll;
$urll= 'http://genome.cs.nthu.edu.tw/R3D-BLAST/results/20131110_SN053/download.php?file=results.txt';

#open(>)
#getstore($urll,$filename); #downloads file


use strict;
use warnings;
use Getopt::Long;

my $folder = "";
my $phyFile = "";
my $partFile = "";
my $version = "13022023";

GetOptions (  "out=s"   => \$folder,
              "phy=s"   => \$phyFile,
              "part=s"   => \$partFile)
  or die("Error in command line arguments");

if($folder eq "" || $phyFile eq "" || $partFile eq ""){
	print "One or more arguments missing, expected 'perl stacks2RAxMLperLocus.pl -out outputFolder -phy phylipFile -part partitionFile'\n";
	exit(1);
}

open my $fh_phy, '<', $phyFile or die "cant read input : $!\n";
open my $fh_part, '<', $partFile or die "cant read input : $!\n";

my @seqs;
my @names;


# read phylip file
my $counter = 0;
my $header;
while(<$fh_phy>){
	chomp;
	if (!$header){
		$header=$_;
		next;
	}
	if ($_ eq ""){
	$counter = 0;
	next;
	}
	else{

	my @fields = split /\s+/,$_;
	if(scalar @fields == 2){
		push @names, $fields[0];
		push @seqs, $fields[1];

		}
		else{
			$seqs[$counter++] .= $_;
			
		}
	}
}


# read partitions file and output fasta files per locus
my $locus = 0;
while(<$fh_part>){
	m/.+(p\d+)\=(\d+)\-(\d+)\n/;

	my $part = $1;
	my $start = $2;
	my $stop = $3;
	my $len = $stop - $start + 1;
	my $start0 = $start - 1 ;
	$locus++;
	open my $fho, '>', "$folder/locus$part.fas" or die "unable to open for writing: $!\n";
	for(my $i = 0; $i <= $#names; $i++){
		print $fho ">$names[$i]\n";
	
		my $seq2 = substr $seqs[$i], $start0, $len;
		print $fho $seq2, "\n";
	}
	close($fho);
}

print "[stacks2RAxMLperLocus v$version] Printed $locus files to folder $folder\n";

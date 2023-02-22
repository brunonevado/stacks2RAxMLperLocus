# stacks2RAxMLperLocus

stacks2RAxMLperLocus: perl script to read phylip output + partition information from stacks (RADseq data), and generate 1 alignment per locus in fasta format. This can be useful for downstream phylogenetic analyses that use gene trees.

Author: B. Nevado  
  
Usage:  
Usage: perl stacks2RAxMLperLocus.pl -phy phylipFile -part partitionFile -out outputFolder 
    -phy: phylip file containing all sequences.
    -part: text file containing partition information.
    -outputFolder: folder to write per-locus files to.  
  
Output: 1 fasta file for each partition defined in -part, written to -out folder.

Note: The input files (phylip and partition files) can be obtained from populations program within the stacks package. The relevant files from populations will be named xxx.all.phylip and xxx.all.partitions.phylip.
 	  Run populations with the option --phylip-var-all and using a population map (-M) that treats each individual as a population. For downstream phylogenetic analyses, would be useful to filter loci in populations using the -R flag (minimum percentage of individuals across populations required to process a locus). 

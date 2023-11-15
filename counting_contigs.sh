#!/bin/bash

##Counting the contigs in a fasta file##

fasta=$1 

grep ">" $fasta | wc -l > contigs.txt

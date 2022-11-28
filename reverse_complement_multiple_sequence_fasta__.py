#!/usr/bin/env python

#This script will get a fasta file and reverse complement all sequences in it;
#It will then create a new fasta with the reverse-complemented sequences.
###usage###
#python reverse_complement_multiple_sequence_fasta__.py path/to/file

from Bio import SeqIO
from Bio.SeqRecord import SeqRecord
from Bio.Seq import Seq
import sys


def reverse_complementing_fasta(fasta):

    sequences = list(SeqIO.parse(fasta, "fasta"))

    with open("reverse_complement.fasta", "w") as handle:

        for record in sequences:

            sequence_header = record.id
            #using reverse_complement function on each record from the list
            rev_comp = record.seq.reverse_complement()

            #writing again the SeqRecod object for each record/sequence
            rev_comp_temp = SeqRecord(rev_comp)

            rev_comp_temp.id = sequence_header
            rev_comp_temp.description = ""

            SeqIO.write(rev_comp_temp, handle, "fasta")


reverse_complementing_fasta(sys.argv[1])

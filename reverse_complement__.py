#!/usr/bin/env python

#Script to reverse complement a given fasta sequence that is too long to use a common web browser tool#
#usage#
#python reverse_complement__.py path/to/file

from Bio import SeqIO
from Bio.SeqRecord import SeqRecord
from Bio.Seq import Seq
import sys


#passing a sequence in the function argument and returning the reverse complement object

def reverse_complement_function(sequence):

    for record in SeqIO.parse(sequence, "fasta"):

        sequence_header = record.id
        rev_comp = record.seq.reverse_complement()

        #converting seq object into seqrecord
        rev_comp_temp = SeqRecord(rev_comp)
        rev_comp_temp.id = sequence_header
        rev_comp_temp.description = ""

    #returning this sequence at the end of the function
    return rev_comp_temp

#Running the function and writing the result into a new fasta file
SeqIO.write(reverse_complement_function(sys.argv[1]), "reverse_complemented_sequence.fasta", "fasta")


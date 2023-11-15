#####Script to order the contigs/scaffolds in a fasta file by the sequence lenghts#####
#####It requires an unwrapped fasta file#####

#Positional argument must be passed on the command line (fasta file)
fasta=$1

#Start with greping the contig names and separating the headers into another file

grep ">" $fasta > HeadersFile

#Find the lenghts of each contig and output the lenghts to another file 

awk '/^>/{if (l!="") print l; print; l=0; next}{l+=length($0)}END{print l}' $fasta > ContigLenghts
paste -d "	" - - < ContigLenghts > ContigLenghtsTabDelimited

#Sort the contig lengths by descend order

sort -k2n -r ContigLenghtsTabDelimited > ContigLenghtsOrdered
awk '{print $1}' ContigLenghtsOrdered > ContigNamesOrdered

#Do a loop on the list of ordered contig names and join with the sequence for each of those contigs

>FastaReordered.fasta; cat ContigNamesOrdered | while read contigName; do grep -w -A 1 "$contigName" $fasta >> FastaReordered.fasta; done

#Remove temporary files 
rm HeadersFile
rm ContigLenghts
rm ContigLenghtsOrdered
rm ContigLenghtsTabDelimited
rm ContigNamesOrdered




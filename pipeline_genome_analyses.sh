#####Pipeline for downstream analyses using the genome assembly of Epidendrum fulgens#####
#####Quality assessment; Annotation and Identification of Repetitive Elements and Transposons; Synteny Analyses; Telomeres; Circos Plots; Candidate Genes for Ecophysiological Responses;

#####Main input: assembly fasta file#####

assembly_fasta=path/to/file
threads=10
output=

#file path of the genome you will be aligning with the reference genome in the synteny analysis
alternate_genome=path/to/file

#set path to dotplotly.R scripts
dotplotly_path=path/to/file

#file path of the EDTA script 
EDTA_script_path=path/to/file

#####Quality assessment#####

###Quast###
###Module Quast has to be installed; Input is the fasta###

quast.py -t $threads -m 1000 -k -e -f $assembly_fasta

###Busco###
###Module Busco has to be installed; There is also the possibility of running through conda and activating the busco environment - considering it has been created;

#conda activate busco

busco -i $assembly_fasta -l  embryophyta_odb10 -o ${output}_embryophyta_odb10 -m genome --cpu $threads


###Telomeric content###
###Module TIDK has to be installed; Or, install through conda and activate the conda enviroment prior to running the command###

#conda activate telomeres

tidk explore --fasta ${assembly_fasta} --minimum 6 --maximum 8 -o telomeric-regions-explore
tidk find --fasta ${assembly_fasta} -c plants -o telomeric-regions-find
tidk search --fasta ${assembly_fasta} --string TTTAGGG -o telomeric-regions-search


#####Synteny Analysis#####

###Alignment with Minimap2 and Plotting with dotplotly.R###
#Input the genome fasta file of the organism you want to align with the reference genome#

minimap2 -t $threads -x asm5 ${assembly_fasta} ${alternate_genome} > minimapAlignment.paf

#Running dotplotly.R for plotting the alignment map#
#DotplotLy has to be in the folder

${dotplotly_path}/pafCoordsDotPlotly.R -i minimapAlignment.paf -o minimapAlignmentPlots.paf -s -x -m 1000 -q 10000



#####Transposable elements characterization#####

###EDTA###
#Perl has to be installed#

perl ${EDTA_script_path} --genome ${assembly_fasta} --sensitive 1 --anno 1 --evaluate 0 --threads 10 --species others --overwrite 0


#! /bin/bash

#set up rna-seq analysis environment and prepare arabidopsis alignment index. 
#First you need to do some setup to make scrits in scripts folder can be executed.
#If you are using Ubuntu, do the following without the comment symbol #
#cd 
#nano .profile
#export PATH="$PATH:$HOME/path to meta-analysis/scripts"  write this to the .profile, 
#path to meta-analysis can be something like this git_temp/meta-analysis, the path after your username
#press ctrl+x, press y, press enter
#log out and log in Ubuntu
#echo $PATH    you should be able see the path you just added
#cd to the root of meta-analysis/scripts
#ls -l     you will see the scripts are not executable
#cd ..
#chmod -R u+x scripts    
#cd scripts
#ls -l   now all the scripts in scripts folder can be execubed. to execube this .sh file,


#make sure you have already done install_R_Rstudio_common_packages.sh and you are at
#the root of meta-analysis repo, and delete the RNA-Seq_workflow folder



#clone the working directories, the structure can been check by the URL
git clone https://github.com/twbattaglia/RNAseq-workflow RNA_Seq_workflow

# Change directory into the new folder
cd RNA_Seq_workflow




# Download the Miniconda3 installer to your home directory (Only for LINUX or Cluster)
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh

# Run the miniconda installation
bash miniconda.sh -b -f -p ~/miniconda

# Add miniconda to the system path
echo 'PATH="$HOME/miniconda/bin:$PATH"' >> ~/.bash_profile

# Source system file to activate miniconda
source ~/.bash_profile

# Add bioinformatic channels for downloading required packages
conda config --add channels conda-forge
conda config --add channels defaults
conda config --add channels r
conda config --add channels bioconda

# Install git (if needed)
conda install -c anaconda git wget --yes

#install fastqc
conda install -c bioconda fastqc --yes

#install trim-galore
conda install -c bioconda trim-galore --yes

#install sortmerna
conda install -c bioconda sortmerna --yes

#install STAR
conda install -c bioconda star --yes







# Download the sortmerna rRNAdatabase package (~2min) into sortmerna_db folder
wget -P sortmerna_db https://github.com/biocore/sortmerna/archive/2.1b.zip

# Decompress folder 
unzip sortmerna_db/2.1b.zip -d sortmerna_db

# Move the database into the correct folder
mv sortmerna_db/sortmerna-2.1b/rRNA_databases/ sortmerna_db/

# Remove unnecessary folders
rm sortmerna_db/2.1b.zip
rm -r sortmerna_db/sortmerna-2.1b

# Save the location of all the databases into one folder
sortmernaREF=sortmerna_db/rRNA_databases/silva-arc-16s-id95.fasta,sortmerna_db/index/silva-arc-16s-id95:\
sortmerna_db/rRNA_databases/silva-arc-23s-id98.fasta,sortmerna_db/index/silva-arc-23s-id98:\
sortmerna_db/rRNA_databases/silva-bac-16s-id90.fasta,sortmerna_db/index/silva-bac-16s-id95:\
sortmerna_db/rRNA_databases/silva-bac-23s-id98.fasta,sortmerna_db/index/silva-bac-23s-id98:\
sortmerna_db/rRNA_databases/silva-euk-18s-id95.fasta,sortmerna_db/index/silva-euk-18s-id95:\
sortmerna_db/rRNA_databases/silva-euk-28s-id98.fasta,sortmerna_db/index/silva-euk-28s-id98

# Run the indexing command (~8 minutes)
indexdb_rna --ref $sortmernaREF



# Download genome fasta file into the genome/ folder   
# it's from Ensembl Genomes FTP site ftp://ftp.ensemblgenomes.org/pub/plants/release-36/
wget -P genome/ ftp://ftp.ensemblgenomes.org/pub/plants/release-36/fasta/arabidopsis_thaliana/dna/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa.gz

# Download annotation file into the annotation/ folder
wget -P annotation/ ftp://ftp.ensemblgenomes.org/pub/plants/release-36/gtf/arabidopsis_thaliana/Arabidopsis_thaliana.TAIR10.36.gtf.gz

# Decompress files for use with tools
gunzip genome/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa.gz
gunzip annotation/Arabidopsis_thaliana.TAIR10.36.gtf.gz


# Generating indexes of the arabidopsis genome. This can take up to 30 minutes to complete
STAR \
--runMode genomeGenerate \
--genomeDir star_index \
--genomeFastaFiles genome/* \
--sjdbGTFfile annotation/* \
--runThreadN 4




#as lots of data to download, will modify this later
#wget -P input/ ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR137/001/SRR1374921/SRR1374921.fastq.gz
#wget -P input/ ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR137/002/SRR1374922/SRR1374922.fastq.gz



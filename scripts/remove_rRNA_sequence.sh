#! /bin/bash

#remove rRNA sequences (optional). If your samples were not prepared with an rRNA depletion protocol before library preparation, it is #reccomended to run this step to computational remove any rRNA sequence contiamation that may otheriwse take up a majority of the aligned #sequences.

# Save variable of rRNA databases
# Save the location of all the databases into one folder
sortmernaREF=sortmerna_db/rRNA_databases/silva-arc-16s-id95.fasta,sortmerna_db/index/silva-arc-16s-id95:\
sortmerna_db/rRNA_databases/silva-arc-23s-id98.fasta,sortmerna_db/index/silva-arc-23s-id98:\
sortmerna_db/rRNA_databases/silva-bac-16s-id90.fasta,sortmerna_db/index/silva-bac-16s-id95:\
sortmerna_db/rRNA_databases/silva-bac-23s-id98.fasta,sortmerna_db/index/silva-bac-23s-id98:\
sortmerna_db/rRNA_databases/silva-euk-18s-id95.fasta,sortmerna_db/index/silva-euk-18s-id95:\
sortmerna_db/rRNA_databases/silva-euk-28s-id98.fasta,sortmerna_db/index/silva-euk-28s-id98

# Run SortMeRNA (~15min)
sortmerna \
--ref $sortmernaREF \
--reads results/2_trimmed_output/sample_trimmed.fq \
--aligned results/3_rRNA/aligned/sample_aligned.fq \
--other results/3_rRNA/filtered/sample_filtered.fq \
--fastx \
--log \
-a 4 \
-v

# Move logs into the correct folder
mv -v results/3_rRNA/aligned//sample_aligned.log results/3_rRNA/logs


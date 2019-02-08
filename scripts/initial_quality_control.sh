#! /bin/bash

#run fastqc and have look at the report

# Run FastQC
fastqc \
-o results/1_initial_qc/ \
--noextract \
input/sample.fastq   #change it later record to metadata
                     #improve it with multiqc later
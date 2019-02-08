#! /bin/bash

#trim low quality base calls from 3'end first, then do adapter trimming according to detection. Ater trimming,
#reads shorter than 20(default) will be discard. usually set --quality 20 and --length 25. For paired end files, discard both short 
#reads if at least one of two are shorter than default 20, remember to add --paired for paired end files.

#-q/--quality <INT>     Trim low-quality ends from reads in addition to adapter removal. For
#                        RRBS samples, quality trimming will be performed first, and adapter
#                        trimming is carried in a second round. Other files are qualityand adapter
#                         trimmed in a single pass. The algorithm is the same as the oneused by BWA
#                         (Subtract INT from all qualities; compute partial sums from all indices
#                         to the end of the sequence; cut sequence at the index at whichthe sum is
#                         minimal). Default Phred score: 20.

#--phred33               Instructs Cutadapt to use ASCII+33 quality scores as Phred scores
#                        (Sanger/Illumina 1.9+ encoding) for quality trimming. Default:ON.

# --phred64               Instructs Cutadapt to use ASCII+64 quality scores as Phred scores
#                         (Illumina 1.5 encoding) for quality trimming.
#--stringency <INT>      Overlap with adapter sequence required to trim a sequence. Defaults to a
#                         very stringent setting of 1, i.e. even a single bp of overlapping sequence
#                         will be trimmed off from the 3' end of any read.

#--length <INT>          Discard reads that became shorter than length INT because of either
#                         quality or adapter trimming. A value of '0' effectively disables
#                         this behaviour. Default: 20 bp.

#                         For paired-end files, both reads of a read-pair need to be longer than
#                         <INT> bp to be printed out to validated paired-end files (see option --paired).
#                         If only one read became too short there is the possibility of keeping such
#                         unpaired single-end reads (see --retain_unpaired). Default pair-cutoff: 20 bp.


#--paired                This option performs length trimming of quality/adapter/RRBS trimmed reads for
#                         paired-end files. To pass the validation test, both sequences of a sequence pair
#                         are required to have a certain minimum length which is governed by the option
#                         --length (see above). If only one read passes this length threshold the
#                         other read can be rescued (see option --retain_unpaired). Using this option lets
#                         you discard too short read pairs without disturbing the sequence-by-sequence order
#                         of FastQ files which is required by many aligners.

#                         Trim Galore! expects paired-end files to be supplied in a pairwise fashion, e.g.
#                         file1_1.fq file1_2.fq SRR2_1.fq.gz SRR2_2.fq.gz ... .

# Run Trim Galore!remember add --paired for paired end files!

trim_galore \
--quality 20 \
--fastqc \
--length 25 \
--output_dir results/2_trimmed_output/ \
input/sample.fastq
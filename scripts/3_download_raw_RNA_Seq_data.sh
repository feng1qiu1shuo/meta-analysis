#! /bin/bash

#batch download RNA-Seq fastq file from EBI-ENA with aspera 
#according to SRR accession number
#need prepare a SRR accession txt file first in the input folder
#make sure you are at the root of meta-analysis folder 

cd RNA_Seq_workflow

cat > input/down_SRR_data.sh
echo "x=$(echo $i | cut -b1-6)" >> input/down_SRR_data.sh
echo "y=$(echo $i | cut -b1-3)" >> input/down_SRR_data.sh
echo "ascp -QT -l 300m -P33001 -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/$x/$i/$i_1.fastq.gz ./" >> input/down_SRR_data.sh
echo "ascp -QT -l 300m -P33001 -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/$x/$i/$i_2.fastq.gz ./" >> input/down_SRR_data.sh


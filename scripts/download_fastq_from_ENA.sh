#! /bin/bash

cd RNA_Seq_workflow
for i in `cat accession.txt`
do
  x=$(echo $i | cut -b1-6)
  y=00$(echo $i | cut -b10)
  ascp -QT -k 1 -l 1000m -P33001 -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/$x/$y/$i/${i}_1.fastq.gz input/
  ascp -QT -k 1 -l 1000m -P33001 -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/$x/$y/$i/${i}_2.fastq.gz input/
done
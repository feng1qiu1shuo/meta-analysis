#! /bin/bash

cd RNA_Seq_workflow
for i in `cat accession.txt`
do
  x=$(echo $i | cut -b1-6)
  y=$(echo $i | cut -b1-3)
  ascp -T -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -k 1 -T -l200m anonftp@ftp-private.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/$y/$x/$i/$i.sra input/
done
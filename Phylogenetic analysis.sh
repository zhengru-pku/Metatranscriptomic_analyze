#!/bin/bash
#SBATCH -p amd_256  
#SBATCH -N 1    
#SBATCH -n 64

source /public1/soft/modules/module.sh
source activate iqtree
export PATH=/public1/home/scb2742/yiming/software/mafft-7.505-with-extensions/scripts/mafft:$PATH

for i in *.fasta 
do
/public1/home/scb2742/yiming/software/mafft-7.505-with-extensions/scripts/mafft --auto --thread 50 ${i} > ${i}align.fasta
iqtree -s ${i}align.fasta -m LG+C60+F+G  -alrt 1000
done


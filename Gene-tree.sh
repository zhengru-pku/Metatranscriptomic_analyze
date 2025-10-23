#!/bin/bash
#SBATCH -p amd_256  
#SBATCH -N 1    
#SBATCH -n 64
source /public1/soft/modules/module.sh
source activate iqtree
export PATH=/public1/home/scb2742/yiming/software/mafft-7.505-with-extensions/scripts/mafft:$PATH


for i in *.fasta 
do
/public1/home/scb2742/yiming/software/mafft-7.505-with-extensions/scripts/mafft --auto --thread 50 ${i} > maff_${i}
iqtree -s maff_${i} -m TEST  -bb 1000  -nt AUTO -m TEST -madd LG4X, LG4M, LG+C10, LG+C20, LG+C30, LG+C40, LG+C50, LG+C60 -wbtl 
done
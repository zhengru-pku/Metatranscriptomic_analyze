#!/bin/bash
#SBATCH -p amd_256  
#SBATCH -N 1    
#SBATCH -n 64

source /public1/soft/modules/module.sh

source activate iqtree
iqtree -s gtdbtk.bac120.user_msa.fasta -m LG+C60+F+G  -alrt 1000

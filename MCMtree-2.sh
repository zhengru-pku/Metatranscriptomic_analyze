#!/bin/bash
#SBATCH -p amd_256  
#SBATCH -N 1    
#SBATCH -n 64

source /public1/soft/modules/module.sh

module purge
module load anaconda/3-Python3.7.3-wjl

source activate paml
mcmctree mcmctree.ctl
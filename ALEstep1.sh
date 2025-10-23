#!/bin/bash
#SBATCH -p amd_256  
#SBATCH -N 1    
#SBATCH -n 64

source /public1/soft/modules/module.sh
module load singularity/3.10.0-oneAPI.2022.1-llvm 

for i in 00282.ufboot  00605.ufboot  02119.ufboot  02124.ufboot  04654.ufboot  14126.ufboot 00283.ufboot  01491.ufboot  02120.ufboot  02437.ufboot  04655.ufboot 00297.ufboot  01938.ufboot  02121.ufboot  04651.ufboot  04656.ufboot 00436.ufboot  02117.ufboot  02122.ufboot  04652.ufboot  06281.ufboot 00600.ufboot  02118.ufboot  02123.ufboot  04653.ufboot  12140.ufboot
do
singularity exec --bind  /public1/home/scb2742/klr/CNdxs/ALE/ALE202509/3:/public1/home/scb2742/klr/CNdxs/ALE/ALE202509/3  /public1/home/scb2742/klr/dk/alesuite.sif  ALEobserve /public1/home/scb2742/klr/CNdxs/ALE/ALE202509/3/${i} > ${prefix}.ale
done

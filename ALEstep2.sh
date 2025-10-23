#!/bin/bash
#SBATCH -p amd_256  
#SBATCH -N 1    
#SBATCH -n 64

source /public1/soft/modules/module.sh
module load singularity/3.10.0-oneAPI.2022.1-llvm 

for i in 00282.ufboot.ale  01938.ufboot.ale  02123.ufboot.ale  04655.ufboot.ale 00283.ufboot.ale  02117.ufboot.ale  02124.ufboot.ale  04656.ufboot.ale 00297.ufboot.ale  02118.ufboot.ale  02437.ufboot.ale  06281.ufboot.ale 00436.ufboot.ale  02119.ufboot.ale  04651.ufboot.ale  12140.ufboot.ale 00600.ufboot.ale  02120.ufboot.ale  04652.ufboot.ale  14126.ufboot.ale 00605.ufboot.ale  02121.ufboot.ale  04653.ufboot.ale 01491.ufboot.ale  02122.ufboot.ale  04654.ufboot.ale
do
singularity exec --bind  /public1/home/scb2742/klr/CNdxs/ALE/ALE202509/3:/public1/home/scb2742/klr/CNdxs/ALE/ALE202509/3 /public1/home/scb2742/klr/dk/alesuite.sif   ALEml_undated /public1/home/scb2742/klr/CNdxs/ALE/nife3/S.tre /public1/home/scb2742/klr/CNdxs/ALE/ALE202509/3/${i} sample=1000 separators=_
done

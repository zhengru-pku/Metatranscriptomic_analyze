#!/bin/bash
#SBATCH -p amd_256      # Slurm partition (adjust to your HPC environment)
#SBATCH -N 1            # Number of nodes
#SBATCH -n 64           # Number of CPUs

# Load required tools (adjust module/environment as needed)
source ./software/profile_meta.sh
export PATH=./software/phylosift/bin:$PATH
export PATH=./software/hmmer/bin:$PATH

# Input and output directories (relative paths)
INPUT_DIR=./data/dereplicated_genomes       # directory with .fa genome files
OUTPUT_DIR=./results/binsize                # directory to save N50/assembly stats
mkdir -p ${OUTPUT_DIR}

# Loop over all .fa genome files
for file in ${INPUT_DIR}/*.fa; do
    filename=$(basename "$file" .fa)
    echo "Processing ${filename}..."

    # Compute assembly statistics using N50Stat.pl
    perl ./software/NGSQCToolkit/Statistics/N50Stat.pl \
        -i "$file" \
        -o "${OUTPUT_DIR}/${filename}.xls"
done




#!/bin/bash
#SBATCH -p amd_256      # Slurm partition
#SBATCH -N 1            # Number of nodes
#SBATCH -n 64           # Number of CPUs

# Load required modules
module purge
module load python/3.6.14-mpi4py-mpicc-openmpi-cjj

# Add BBMap to PATH (relative path or environment variable)
export PATH=./software/bbmap/:$PATH

# Input directories
RAW_DIR=./data/raw_fastq       # raw paired-end FASTQ files
REF_GENOME=./data/reference/all.fa  # reference genome
OUTPUT_DIR=./results/bbmap      # output SAM/RPKM files
mkdir -p ${OUTPUT_DIR}

# List of sample IDs
for SAMPLE in xxxx; do
    echo "Processing sample ${SAMPLE}..."

    # Run BBMap mapping
    bbmap.sh \
        in1=${RAW_DIR}/${SAMPLE}.R1.raw.fastq \
        in2=${RAW_DIR}/${SAMPLE}.R2.raw.fastq \
        out=${OUTPUT_DIR}/${SAMPLE}_bin.sam \
        outm=${OUTPUT_DIR}/${SAMPLE}_bin.map.sam \
        minid=0.95 \
        ambig=random \
        rpkm=${OUTPUT_DIR}/${SAMPLE}_bin.rpkm.xls \
        ref=${REF_GENOME} \
        nodisk
done



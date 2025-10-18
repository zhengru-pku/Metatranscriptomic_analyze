#!/bin/bash
#SBATCH -p amd_256      # Slurm partition (adjust to your HPC environment)
#SBATCH -N 5            # Number of nodes
#SBATCH -n 320          # Number of CPUs

# Load necessary modules (adjust to your environment)
module purge
module load mpi/intel/17.0.7-thc

# Add SeqPrep to PATH (use relative path or environment variable)
export PATH=./software/SeqPrep:$PATH

# Input directory for raw FASTQ files
RAW_DIR=./data/raw_fastq
# Output directory for trimmed/cleaned FASTQ files
OUT_DIR=./results/clean_fastq
mkdir -p ${OUT_DIR}

# Adapter sequences
ADAPTER_FWD="AGATCGGAAGAGCGTCGTGT"
ADAPTER_REV="AGATCGGAAGAGCACACGTC"

# Loop over sample IDs (can expand as needed)
for SAMPLE in A; do
    echo "Processing sample ${SAMPLE}..."

    # Step 1: Adapter trimming with SeqPrep
    SeqPrep \
        -f ${RAW_DIR}/${SAMPLE}.R1.raw.fastq \
        -r ${RAW_DIR}/${SAMPLE}.R2.raw.fastq \
        -1 ${OUT_DIR}/${SAMPLE}.clip.1.fq \
        -2 ${OUT_DIR}/${SAMPLE}.clip.2.fq \
        -3 ${OUT_DIR}/${SAMPLE}.discard.1.fq \
        -4 ${OUT_DIR}/${SAMPLE}.discard.2.fq \
        -B ${ADAPTER_FWD} \
        -A ${ADAPTER_REV}

    # Step 2: Quality trimming with sickle
    sickle pe \
        -f ${OUT_DIR}/${SAMPLE}.clip.1.fq \
        -r ${OUT_DIR}/${SAMPLE}.clip.2.fq \
        -t sanger \
        -q 20 \
        -l 50 \
        -n \
        -o ${OUT_DIR}/${SAMPLE}.clip.sickle.1.fq \
        -p ${OUT_DIR}/${SAMPLE}.clip.sickle.2.fq \
        -s ${OUT_DIR}/${SAMPLE}.clip.sickle.s.fq \
        > ${OUT_DIR}/${SAMPLE}.clip.sickle.log
done








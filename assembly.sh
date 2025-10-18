#!/bin/bash
#SBATCH -p amd_256      # Slurm partition (adjust to your HPC environment)
#SBATCH -N 5            # Number of nodes
#SBATCH -n 320          # Number of CPUs

# Load required modules
module purge
module load python/3.6.14-mpi4py-mpicc-openmpi-cjj

# Input and output directories (relative paths)
QC_DIR=./results/clean_fastq      # input trimmed FASTQ files from Step1
ASSEMBLY_DIR=./results/assembly   # output assembly directory
mkdir -p ${ASSEMBLY_DIR}

# List of sample IDs to process
for SAMPLE in A; do
    echo "Processing sample ${SAMPLE}..."

    # Create a working directory for each sample
    mkdir -p ${SAMPLE}

    # Step 1: Merge paired-end reads into FASTA using fq2fa
    fq2fa --merge \
        ${QC_DIR}/${SAMPLE}.clip.sickle.1.fq \
        ${QC_DIR}/${SAMPLE}.clip.sickle.2.fq \
        ${SAMPLE}/1.merge12.fa

    # Step 2: Convert unpaired reads to FASTA
    fq2fa \
        ${QC_DIR}/${SAMPLE}.clip.sickle.s.fq \
        ${SAMPLE}/1.clean.s.fa

    # Step 3: Combine merged paired-end and unpaired reads
    cat ${SAMPLE}/1.merge12.fa ${SAMPLE}/1.clean.s.fa > ${SAMPLE}/1.merge.fa

    # Step 4: Assemble with IDBA-UD
    idba_ud -r ${SAMPLE}/1.merge.fa -o ${ASSEMBLY_DIR}/${SAMPLE} --pre_correction

done


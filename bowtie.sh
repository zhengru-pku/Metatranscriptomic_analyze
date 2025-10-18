#!/bin/bash
#SBATCH -p amd_256      # Slurm partition
#SBATCH -N 5            # Number of nodes
#SBATCH -n 320          # Number of CPUs

# Load modules
module purge
module load python/3.6.14-mpi4py-mpicc-openmpi-cjj
module load bowtie2/2.3.4.1-zyq
module load samtools

# Input/output directories (relative paths)
ASSEMBLY_DIR=./results/assembly    # scaffold fasta files
RAW_DIR=./data/raw_fastq           # raw reads
OUTPUT_DIR=./results/bowtie        # bowtie2 mapping outputs
mkdir -p ${OUTPUT_DIR}

# Sample IDs
for SAMPLE in A; do
    echo "Processing sample ${SAMPLE}..."

    # Create working directory for sample
    mkdir -p ${OUTPUT_DIR}/${SAMPLE}
    cd ${OUTPUT_DIR}/${SAMPLE}

    # Copy and rename scaffold
    cp ${ASSEMBLY_DIR}/${SAMPLE}/scaffold.fa ./
    mv scaffold.fa ${SAMPLE}.scaffold.fasta

    # Build Bowtie2 index
    bowtie2-build ${SAMPLE}.scaffold.fasta ${SAMPLE}

    # Map reads with Bowtie2
    bowtie2 -p 8 \
        -x ${SAMPLE} \
        -1 ${RAW_DIR}/${SAMPLE}.R1.raw.fastq \
        -2 ${RAW_DIR}/${SAMPLE}.R2.raw.fastq \
        -S ${SAMPLE}.sam

    # Convert SAM to BAM and sort
    samtools view -bS ${SAMPLE}.sam > ${SAMPLE}.bam
    samtools sort ${SAMPLE}.bam -o ${SAMPLE}.sorted.bam

    # Clean up intermediate files
    rm *.bt2
    rm *.sam

    # Return to parent directory
    cd ../../
done



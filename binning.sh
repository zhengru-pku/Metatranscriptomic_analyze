#!/bin/bash
#SBATCH -p amd_256      # Slurm partition
#SBATCH -N 1            # Number of nodes
#SBATCH -n 64           # Number of CPUs

# Load required modules
module purge
module load python/3.6.14-mpi4py-mpicc-openmpi-cjj

# Add MetaBAT to PATH (relative path or environment variable)
export PATH=./software/metabat/:$PATH

# Directories
BAM_DIR=./results/bowtie      # input BAM files
SCAFFOLD_DIR=./results/scaffold  # input scaffold fasta files
BINNING_DIR=./results/binning  # output bins
mkdir -p ${BINNING_DIR}

# List of sample IDs
for SAMPLE in A; do
    echo "Processing sample ${SAMPLE}..."

    # Create working directory
    mkdir -p ${SAMPLE}
    cd ${SAMPLE}

    # Copy BAM and scaffold files into working directory
    cp ${BAM_DIR}/${SAMPLE}/*.bam ./
    cp ${SCAFFOLD_DIR}/${SAMPLE}/${SAMPLE}.scaffold.fasta ./

    # Summarize BAM depth per contig
    jgi_summarize_bam_contig_depths --outputDepth depth.txt *.sorted.bam

    # Run MetaBAT2 for binning
    metabat2 -i ${SAMPLE}.scaffold.fasta -a depth.txt -o ../${BINNING_DIR}/${SAMPLE}/bins_dir/bin -v -m 1500

    # Clean up BAM files
    rm *.bam

    # Return to parent directory
    cd ..
done







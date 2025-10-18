#!/bin/bash
#SBATCH -p amd_256      # Slurm partition
#SBATCH -N 1            # Number of nodes
#SBATCH -n 64           # Number of CPUs

# Load modules
module purge
module load python/3.6.14-mpi4py-mpicc-openmpi-cjj

# Add Prodigal to PATH (relative path)
export PATH=./software/Prodigal-2.6.3/:$PATH

# Define input and output directories
INPUT_DIR=./data/dereplicated_genomes      # directory with .fa genome files
OUTDIR=./results/dereplicated_genomes/ORF  # output directory
mkdir -p ${OUTDIR}/faa ${OUTDIR}/mrna ${OUTDIR}/gff

# Loop over all .fa genome files
for GENOME in ${INPUT_DIR}/*.fa; do
    filename=$(basename "${GENOME}" .fa)
    echo "Processing genome ${filename}..."

    prodigal \
        -i ${GENOME} \
        -f gff \
        -o ${OUTDIR}/gff/${filename}.gff \
        -a ${OUTDIR}/faa/${filename}.protein.faa \
        -d ${OUTDIR}/mrna/${filename}.mrna.fa
done


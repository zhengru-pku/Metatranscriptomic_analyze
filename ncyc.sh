#!/bin/bash
#SBATCH -p amd_256      # Slurm partition
#SBATCH -N 1            # Number of nodes
#SBATCH -n 64           # Number of CPUs

# Load modules
module purge
module load python/3.6.14-mpi4py-mpicc-openmpi-cjj

# Add Diamond to PATH (relative path)
export PATH=./software/Diamond:$PATH

# Input/output directories (relative paths)
DB_DIR=./data/ncyc             # Diamond database directory
QUERY_DIR=./results/orfs        # Protein sequences to search
OUTPUT_DIR=./results/diamond    # Output directory
mkdir -p ${OUTPUT_DIR}

# Sample or protein file
QUERY=A18039.faa

diamond blastp \
    -d ${DB_DIR}/NCyc_100.dmnd \
    -q ${QUERY_DIR}/${QUERY} \
    -o ${OUTPUT_DIR}/${QUERY%.faa}.out \
    --more-sensitive \
    -e 1e-5 \
    -f 6 \
    -k 25 \
    --threads 20






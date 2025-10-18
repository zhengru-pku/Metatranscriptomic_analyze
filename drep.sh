#!/bin/bash
#SBATCH -p amd_256      # Slurm partition
#SBATCH -N 1            # Number of nodes
#SBATCH -n 64           # Number of CPUs

# Load conda environment
module purge
module load miniforge/24.11
source activate ./envs/py365   # 使用相对路径或环境名

# Add software to PATH (use relative paths)
export PATH=./software/ANIcalculator_v1:$PATH
export PATH=./software/mummer/bin:$PATH
export PATH=./software/aa:$PATH
export PATH=./software/mash-Linux64-v2.3:$PATH

# Input directories (relative paths)
GENOME_DIR=./results/bin        # input genome bins
DREP_OUTPUT=./results/drep      # output directory
mkdir -p ${DREP_OUTPUT}

# Run dRep dereplication
dRep dereplicate ${DREP_OUTPUT} \
    -g ${GENOME_DIR}/*.fa \
    -pa 0.9 \
    -sa 0.95 \
    -cm larger \
    -comp 70 \
    -con 10 \
    -nc 0.30 \
    -strW 0 \
    -p 14


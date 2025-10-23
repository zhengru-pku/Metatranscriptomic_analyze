#!/bin/bash
#SBATCH -p amd_256  
#SBATCH -N 1    
#SBATCH -n 64


ls *.faa > fasta_files.txt
source activate  /public1/home/scb2742/.conda/envs/mamba/envs/gtotree

GToTree -A fasta_files.txt    -H Bacteria  -o example75 -k -d -G 0.0


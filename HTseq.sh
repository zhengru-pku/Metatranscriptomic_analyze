#!/bin/bash
#SBATCH -p amd_256      # Slurm partition
#SBATCH -N 1            # Number of nodes
#SBATCH -n 64           # Number of CPUs

# Load conda environment
# module purge
# module load anaconda/3-Python3.6.5-fgl
source activate new   # 或者使用相对路径的环境名

# Input directories (relative paths)
BAM_DIR=./results/bbmap       # 输入 map.sam 文件目录
GFF_FILE=./data/gff/fixed_all_clean.gff  # 基因注释文件
OUTPUT_DIR=./results/htseq    # 输出计数文件
mkdir -p ${OUTPUT_DIR}

# Sample IDs
for SAMPLE in XXX; do
    echo "Processing sample ${SAMPLE}..."

    python -m HTSeq.scripts.count \
        -r name \               # 按 read name 排序
        -m intersection-strict \ # 严格模式计数
        -t CDS \                 # feature type: CDS
        -s no \                  # unstranded
        -i ID \                  # feature ID 属性
        ${BAM_DIR}/${SAMPLE}_bin.map.sam \  # 输入 BAM/SAM 文件
        ${GFF_FILE} > ${OUTPUT_DIR}/${SAMPLE}.xls
done

#!/bin/bash

# Specify a job name
#$ -N ahuang

# Project name and target queue
#$ -P procardis.prjc
#$ -q short.qc

# Run the job in the current working directory
#$ -cwd -j y

# Log locations which are relative to the current
# working directory of the submission
###$ -o output.log
###$ -e error.log

# Parallel environemnt settings
#  For more information on these please see the wiki
#  Allowed settings:
#   shmem
#   mpi
#   node_mpi
#   ramdisk
#$ -pe shmem 2

# Some useful data about the job to help with debugging
echo "------------------------------------------------"
echo "SGE Job ID: $JOB_ID"
echo "SGE Task ID: $SGE_TASK_ID"
echo "Run on host: "`hostname`
echo "Operating system: "`uname -s`
echo "Username: "`whoami`
echo "Started at: "`date`
echo "------------------------------------------------"

# Begin writing your script here

/well/PROCARDIS/users/fyb425/cellranger/cellranger-6.1.2/bin/cellranger count --id=SRR7722937 \
--transcriptome=/well/PROCARDIS/users/fyb425/cellranger/refdata-gex-GRCh38-and-mm10-2020-A \
--fastqs=/well/PROCARDIS/users/fyb425/project/single_cell/raw/SRR7722937/SRR7722937_raw \
--sample=SRR7722937 \
--nosecondary

echo $JOB_ID

# End of job script

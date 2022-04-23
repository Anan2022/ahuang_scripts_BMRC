#!/bin/bash

# Specify a job name
#$ -N ahuang

# Project name and target queue
#$ -P procardis.prjc
#$ -q test.qc

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
#$ -pe shmem 1

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
cd /well/PROCARDIS/users/fyb425
module load FastQC/0.11.9-Java-11
fastqc /well/PROCARDIS/users/fyb425/SRR121621_1.fastq

echo $JOB_ID

# End of job script

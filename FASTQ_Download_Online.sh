#!/bin/bash

# Specify a job name
#$ -N jobname

# Project name and target queue
#$ -P group.prjc
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

# Type in Enropean Nucleotide Archive webist
# Search the sequence data you want
# You will find "Generated FastQ files: FTP"
# It always has two files for each sample (Forward strand and Reverse strand)
# Right click the file to copy the link ---
 # ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR490/001/ERR4902081/ERR4902081_1.fastq.gz 
# Thun run this code below
   # ascp -QT -l 300m -P 33001 -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/ERR490/002/ERR4902082/ERR4902082_1.fastq.gz Path/TO/Save/Files


echo $JOB_ID

# End of job script

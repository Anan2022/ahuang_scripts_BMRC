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
#$ -pe shmem 3

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

java -jar /well/PROCARDIS/users/fyb425/single_cell_data/picard/build/libs/picard.jar CollectRnaSeqMetrics \
-I /well/PROCARDIS/users/fyb425/single_cell_data/single_sam_file/ERR4902083.sorted.bam \
-O /well/PROCARDIS/users/fyb425/single_cell_data/single_sam_file/ERR4902083.RNA_Metrics \
-REF_FLAT /well/PROCARDIS/users/fyb425/annotation/picard_ref/refFlat.txt \
-STRAND SECOND_READ_TRANSCRIPTION_STRAND

echo $JOB_ID

# End of job script

#!/bin/bash

# note that you must load whichever main Python module you used to create your virtual environments before activating the virtual environment
module load Python/3.7.4-GCCcore-8.3.0


# Activate the ivybridge or skylake version of your python virtual environment
# NB The environment variable MODULE_CPU_TYPE will evaluate to ivybridge or skylake as appropriate
source /well/PROCARDIS/users/fyb425/python/projectA-skylake/bin/activate

# continue to use your python venv as normal

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

module load HISAT2/2.2.1-foss-2019b

hisat2 \
-x /well/PROCARDIS/users/fyb425/annotation/grcm38/genome \
-1 /well/PROCARDIS/users/fyb425/single_cell_data/ERR4902083_1.fastq.gz \
-2 /well/PROCARDIS/users/fyb425/single_cell_data/ERR4902083_2.fastq.gz \
--rna-strandness RF \
--summary-file ERR4902083_stats.txt \
-S ERR4902083.sam \
--verbose
echo $JOB_ID

# End of job script
